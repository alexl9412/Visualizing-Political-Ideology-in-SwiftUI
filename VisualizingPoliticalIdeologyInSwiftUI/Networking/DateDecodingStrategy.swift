//
//  DateDecodingStrategy.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/13/25.
//

import Foundation

let dateFormats = [
	"yyyy-MM-dd'T'HH:mm:ss",      // e.g. "2023-01-04T15:23:12"
	"yyyy/MM/dd HH:mm:ss",         // e.g. "2023/01/04 15:23:12"
	"MM-dd-yyyy HH:mm:ss",         // e.g. "01-04-2023 15:23:12"
	"yyyy-MM-dd"                   // e.g. "2023-01-04"
]

func decodeDate(from string: String) -> Date? {
	for format in dateFormats {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		if let date = formatter.date(from: string) {
			return date
		}
	}
	return nil // Return nil if no format matches
}

extension JSONDecoder.DateDecodingStrategy {
	static let customDateStrategy: JSONDecoder.DateDecodingStrategy = .custom { decoder in
		let container = try decoder.singleValueContainer()
		let dateString = try container.decode(String.self)
		
		// Try to decode the date using the custom decodeDate method
		if let date = decodeDate(from: dateString) {
			return date
		} else {
			throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unable to decode date string.")
		}
	}
}
