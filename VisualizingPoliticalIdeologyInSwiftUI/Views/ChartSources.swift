//
//  ChartSources.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/15/25.
//

import SwiftUI

struct ChartSources: View {
	let sources: [CustomURL]
	let bullet: String =  "•"

	var body: some View {
		VStack(alignment: .leading) {
			Text("Sources:")
				.fontWeight(.semibold)
			ForEach(sources, id: \.self) { source in
				Link(destination: URL(string: source.url)!) {
					if source.pageTitle.isEmpty || source.siteTitle.isEmpty {
						HStack(alignment: .top) {
							Text(bullet).bold()
							Text(source.pageTitle)
							+ Text(source.siteTitle)
								.italic()
						}
					} else {
						HStack(alignment: .top) {
							Text(bullet).bold()
							Text(source.pageTitle)
							+ Text(" | ")
							+ Text(source.siteTitle)
								.italic()
						}
					}
				}
				.padding(.horizontal)
				.buttonStyle(.plain)
			}
		}
		.font(.footnote)
		.foregroundStyle(.secondary)
		.padding(.bottom, 6)
	}
}

struct CustomURL: Hashable, Identifiable {
	let pageTitle: String
	let siteTitle: String
	let url: String
	let id = UUID()
}
