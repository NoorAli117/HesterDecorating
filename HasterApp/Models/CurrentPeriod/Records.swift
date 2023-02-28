

import Foundation
struct Records : Codable {
	var injury_free_day : String?
	var reg_hours : String?
	var job_address : String?
	var emp_locked : String?
	var job_title : String?
	var dc : String?
	var ot_hours : String?
	var start_time : String?
	var job_no : String?
	var end_time : String?
	var id : String?

	enum CodingKeys: String, CodingKey {

		case injury_free_day = "injury_free_day"
		case reg_hours = "reg_hours"
		case job_address = "job_address"
		case emp_locked = "emp_locked"
		case job_title = "job_title"
		case dc = "dc"
		case ot_hours = "ot_hours"
		case start_time = "start_time"
		case job_no = "job_no"
		case end_time = "end_time"
		case id = "id"
	}
}
