/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

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

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		injury_free_day = try values.decodeIfPresent(String.self, forKey: .injury_free_day)
		reg_hours = try values.decodeIfPresent(String.self, forKey: .reg_hours)
		job_address = try values.decodeIfPresent(String.self, forKey: .job_address)
		emp_locked = try values.decodeIfPresent(String.self, forKey: .emp_locked)
		job_title = try values.decodeIfPresent(String.self, forKey: .job_title)
		dc = try values.decodeIfPresent(String.self, forKey: .dc)
		ot_hours = try values.decodeIfPresent(String.self, forKey: .ot_hours)
		start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
		job_no = try values.decodeIfPresent(String.self, forKey: .job_no)
		end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
		id = try values.decodeIfPresent(String.self, forKey: .id)
	}

}
