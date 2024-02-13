//
//  Networking.swift
//  HesterDecorating
//
//  Created by Usama Ali on 29/06/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager: NSObject {
    
    private enum NetworkPath: String {
        case login = "login.php"
        case jobs = "jobs.php"
        case jobhistory = "history.php"
        case startTime = "timeclock.php"
        case sds = "sds.php"
        case updateJob = "timeclock-update.php"
        case currentPeriod = "current-period.php"
        case jobsBulkUpdate = "timeclock-update-bulk.php"
        case dailyTask = "https://job.hpd-painters.com/wp-json/hester-timeclock/v1/add"
        static let baseURL = "https://job.hpd-painters.com/api/"
        
        var url: String {
            return NetworkPath.baseURL + self.rawValue
        }
    }
    
    private struct NetworkParameter {
        static let deviceToken = "deviceToken"
        static let hashtags = "hashtags"
        static let tweetRequestId = "tweetRequestId"
        static let tweetId = "tweetId"
    }
    
    // MARK:- TweetRequest services
    
    
    static func signinRequest(userName: String, password: String, completion: @escaping (CheckUserData?,Bool) -> Void) {
        let urlString = NetworkPath.login.url
        let str = "\(userName)::\(password)".toBase64()
        let parameters = ["auth": str.reverse()]
        AF.request(urlString, method: .post, parameters: parameters).responseString { response in
            if response.response?.statusCode == 200{
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let tweetRequest = try decoder.decode(CheckUserData.self, from: data)
                    UserDefaults.standard.set(data, forKey: "loginData")
                    completion(tweetRequest,true)
                } catch let error {
                    print(error)
                    completion(nil,false)
                }
            }
        }
    }
    
    static func getJobs(completion: @escaping (CheckJobsData?) -> Void) {
        let urlString = NetworkPath.jobs.url
        AF.request(urlString).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let tweetRequest = try decoder.decode(CheckJobsData.self, from: data)
                completion(tweetRequest)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
    static func getSds(search:String,completion: @escaping (CheckSDS?) -> Void) {
        let urlString = NetworkPath.sds.url
        let parameters = ["q": search]
        print(urlString)
        print(parameters)
        AF.request(urlString, method: .post, parameters: parameters).responseString { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let tweetRequest = try decoder.decode(CheckSDS.self, from: data)
                completion(tweetRequest)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
    static func jobHistory(eid:String, completion: @escaping (CheckGetJobs?,Bool) -> Void) {
        let urlString = NetworkPath.jobhistory.url
        let parameters = ["eid": eid]
        AF.request(urlString, method: .post, parameters: parameters).responseString { response in
            if response.response?.statusCode == 200{
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let tweetRequest = try decoder.decode(CheckGetJobs.self, from: data)
                    completion(tweetRequest,true)
                } catch let error {
                    print(error)
                    completion(nil,false)
                }
            }
        }
    }
    static func currentPeriod(eid:String, completion: @escaping (CheckGetJobs?,Bool) -> Void) {
        let urlString = NetworkPath.currentPeriod.url
        
        let parameters = ["eid": eid]
        AF.request(urlString, method: .post, parameters: parameters).responseString { response in
            if response.response?.statusCode == 200{
                guard let data = response.data else { return }
                do {
                    print(JSON(data))
                    let decoder = JSONDecoder()
                    let tweetRequest = try decoder.decode(CheckGetJobs.self, from: data)
                    completion(tweetRequest,true)
                } catch let error {
                    print(error)
                    completion(nil,false)
                }
            }
        }
    }
    
    static func jobStart(uid: String, job_number: String,dc:Int,start_time:String,reg_hours:Int,otHours:Int,covid:Bool,ip:String, completion: @escaping (String?,Bool) -> Void) {
        let urlString = NetworkPath.startTime.url
        
        let parameters = ["uid": uid,
                          "is_starttime":"1",
                          "dc" : dc,
                          "job_number" : job_number,
                          "start_time" : start_time,
                          "reg_hours": reg_hours,
                          "ot_hours": otHours,
                          "covid":covid,
                          "ip":ip
                          
        ] as [String : Any]
        print(parameters)
        AF.request(urlString, method: .post, parameters: parameters).responseString { response in
            if response.response?.statusCode == 200{
                let mess = JSON(response.data)["message"].string
                completion(mess,true)
            }
            else{
                completion(nil,false)
            }
        }
    }
    static func jobEnd(uid: String, job_number: String,end_time:String,injury_free_day:Int,ip:String, completion: @escaping (String?,Bool) -> Void) {
        let urlString = NetworkPath.startTime.url
        
        let parameters = ["uid": uid,
                          "job_number" : job_number,
                          "end_time" : end_time,
                          "injury_free_day": injury_free_day,
                          "ip":ip
                          
        ] as [String : Any]
        print(parameters)
        AF.request(urlString, method: .post, parameters: parameters).responseString { response in
            if response.response?.statusCode == 200{
                let mess = JSON(response.data)["message"].string
                completion(mess,true)
            }else{
                completion(nil,false)
            }
        }
    }
    
    static func jobUpdate(id:String,uid: String, job_number: String,dc:String,start_time:String,end_time:String,reg_hours:String,otHours:String,injury_free_day:String,emp_locked:String, completion: @escaping (String?,Bool) -> Void) {
        let urlString = NetworkPath.updateJob.url
        let parameters = ["id":id,
                          "uid": uid,
                          "end_time":end_time,
                          "start_time" : start_time,
                          "dc" : dc,
                          "reg_hours": reg_hours,
                          "ot_hours": otHours,
                          "injury_free_day":injury_free_day,
                          "emp_locked":emp_locked
                          
        ] as [String : Any]
        print(urlString)
        print(parameters)
        AF.request(urlString, method: .post, parameters: parameters).responseString { response in
            if response.response?.statusCode == 200{
                let mess = JSON(response.data)["message"].string
                completion(mess,true)
            }
            else{
                completion(nil,false)
            }
        }
    }
    
    static func jobBulkUpdate(id: String, records:[Records], completion: @escaping (String?,Bool) -> Void) {
        let urlString = NetworkPath.jobsBulkUpdate.url
        
        var record : [[String:Any]] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        for a in records{
            let startDate = dateFormatter.date(from: a.start_time ?? "")
            let endDate = dateFormatter.date(from: a.end_time ?? "")
            if (startDate ?? Date()) > (endDate ?? Date()) {
                completion("End date time should be greater than start date time", false)
                return
            }
            let dict  = [
                "id":a.id ?? "",
                "end_time":a.end_time ?? "",
                "start_time" : a.start_time ?? "",
                "dc" : a.dc ?? "14",
                "reg_hours": a.reg_hours ?? "1",
                "ot_hours": a.ot_hours ?? "0",
                "injury_free_day":a.injury_free_day ?? "1",
                "emp_locked":a.emp_locked ?? "0"
            ] as [String : Any]
            record.append(dict)
        }
        let parameters = ["uid":id,
                          "records" : JSON(record)
        ] as [String : Any]
        print(parameters)
        AF.request(urlString, method: .post, parameters: parameters).responseString { response in
            if response.response?.statusCode == 200{
                let mess = JSON(response.data)["message"].string
                completion(mess,true)
            }
            else{
                completion(nil,false)
            }
        }
    }
    
    static func submitDailyTask(model: DailyTaskModel, completion: @escaping (String?,Bool) -> Void) {
        let urlString = NetworkPath.dailyTask.rawValue
        
        var parameters: [String: Any] = [
            "lead_painter": model.leadPainter,
            "date": model.date,
            "project_name": model.projectName,
            "job_number": model.jobNumber,
            "task_completed": model.taskCompleted
        ] as [ String: Any ]
        
        var index = 1
        for x in 0..<model.safetyItemObj.count {
            for y in 0..<model.safetyItemObj[x].options.count {
                parameters.append(["q\(index)": "\(model.safetyItemObj[x].options[y].selection ?? 0)"])
                index += 1
            }
        }
        
        for x in 0..<model.incidentObj.count {
            parameters.append(["q\(index)": "\(model.incidentObj[x].selection ?? 0)"])
        }
        
        parameters.append(["add_analytic_data": "yes"])
        parameters.append(["today_performed": model.workTaskPerformaceList.list])
        parameters.append(["aware_of": model.potentialHazardList.list])
        parameters.append(["employee_signature": model.employeeSignatureList.list])
        
        print("URL: ", urlString)
        print("Params: ", parameters)
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString { response in
            guard let data = response.data else { return }
            do {
                guard let dataString = String.init(data:data, encoding: .utf8) else { return }
                print("Output", dataString)
                
                let decoder = JSONDecoder()
                let model = try decoder.decode(DailyTaskResponse.self, from: data) as DailyTaskResponse
                
                if response.response?.statusCode == 200{
                    completion(model.message ?? "", true)
                }
                else {
                    completion(model.message, false)
                }
            } catch let error {
                print(error)
                completion(error.localizedDescription,false)
            }
        }
    }
    
}

extension Dictionary where Key == String, Value == Any {
    
    mutating func append(_ dict: [String:Any]) {
        for (key, value) in dict {
            self.updateValue(value, forKey: key)
        }
    }
}
