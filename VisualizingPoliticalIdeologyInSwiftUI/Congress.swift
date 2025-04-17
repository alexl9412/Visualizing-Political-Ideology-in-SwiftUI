//
//  Congress.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/15/25.
//

import Foundation

enum Congress: Int, CaseIterable {
	case congress119 = 119
	case congress118 = 118
	case congress117 = 117
	case congress116 = 116
	case congress115 = 115
	case congress114 = 114
	case congress113 = 113
	case congress112 = 112
	case congress111 = 111
	case congress110 = 110
	case congress109 = 109
	case congress108 = 108
	case congress107 = 107
	case congress106 = 106
	case congress105 = 105
	case congress104 = 104
	case congress103 = 103
	case congress102 = 102
	case congress101 = 101
	case congress100 = 100
	case congress99 = 99
	case congress98 = 98
	case congress97 = 97
	case congress96 = 96
	case congress95 = 95
	case congress94 = 94
	case congress93 = 93
	case congress92 = 92
	case congress91 = 91
	case congress90 = 90
	case congress89 = 89
	case congress88 = 88
	case congress87 = 87
	case congress86 = 86
	case congress85 = 85
	case congress84 = 84
	case congress83 = 83
	case congress82 = 82
	case congress81 = 81
	case congress80 = 80
	
	var displayText: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .ordinal
		let number = NSNumber(value: self.rawValue)
		let formattedValue = formatter.string(from: number)!
		
		return "\(formattedValue) Congress"
	}

	func convertToYear() -> Date {
		var comps = DateComponents()
		comps.day = 1
		comps.month = 1
		comps.year = self.year

		let date = Calendar.current.date(from: comps)!
		return date
	}
	
	static func findCase(for congress: Int) -> Congress {
		Congress(rawValue: congress) ?? .congress119
	}
		
	var year: Int {
		self.rawValue * 2 + 1787
	}
}
