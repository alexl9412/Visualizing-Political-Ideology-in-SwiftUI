//
//  ChartFootnote.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/15/25.
//

import SwiftUI

struct ChartFootnote<Content: View>: View {
	let content: Content
	
	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			Text("Notes:")
				.fontWeight(.semibold)
			content
		}
		.font(.footnote)
		.foregroundStyle(.secondary)
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.bottom, 6)
	}
}
