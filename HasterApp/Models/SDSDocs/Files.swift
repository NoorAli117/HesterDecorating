

import Foundation
struct Files : Codable {
	let url : String?
	let name : String?
	let supplier : String?
	let date_added : String?
	let date_modified : String?

	enum CodingKeys: String, CodingKey {

		case url = "url"
		case name = "name"
		case supplier = "supplier"
		case date_added = "date_added"
		case date_modified = "date_modified"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		supplier = try values.decodeIfPresent(String.self, forKey: .supplier)
		date_added = try values.decodeIfPresent(String.self, forKey: .date_added)
		date_modified = try values.decodeIfPresent(String.self, forKey: .date_modified)
	}

}
