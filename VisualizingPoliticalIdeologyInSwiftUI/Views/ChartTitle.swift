//
//  ChartTitle.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/15/25.
//

import SwiftUI

struct ChartTitle: View {
	let headline: String
	let subheadline: String
	
	var body: some View {
		VStack(alignment: .leading) {
			Text(headline)
				.font(.title2).bold()
			Text(subheadline)
				.foregroundStyle(.secondary)
				.fontWeight(.medium)
		}
	}
}
