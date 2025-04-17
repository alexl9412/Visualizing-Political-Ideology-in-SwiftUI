//
//  ChartData.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/17/25.
//

import Foundation

struct ChartData: Identifiable, Hashable {
	let id: UUID
	let congress: Int
	let median: Double
	let party: String
}
