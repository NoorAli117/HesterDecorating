
import Foundation
struct CheckJobsData : Codable {
	let status : Int?
	let message : String?
	let total_jobs : Int?
	let data : [JobsData]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case total_jobs = "total_jobs"
		case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		total_jobs = try values.decodeIfPresent(Int.self, forKey: .total_jobs)
		data = try values.decodeIfPresent([JobsData].self, forKey: .data)
	}

}
