

import Foundation
struct JobsData : Codable {
	var job_number : String?
	var job_name : String?
	var job_address : String?
    init(){
        
    }
	enum CodingKeys: String, CodingKey {

		case job_number = "job_number"
		case job_name = "job_name"
		case job_address = "job_address"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		job_number = try values.decodeIfPresent(String.self, forKey: .job_number)
		job_name = try values.decodeIfPresent(String.self, forKey: .job_name)
		job_address = try values.decodeIfPresent(String.self, forKey: .job_address)
	}

}
