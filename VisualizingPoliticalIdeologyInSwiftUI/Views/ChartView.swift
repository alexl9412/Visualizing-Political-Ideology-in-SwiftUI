//
//  ChartView.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/16/25.
//

import SwiftUI
import Charts

struct ChartView: View {
	let chartData: [ChartData]
	@State private var showCongressMedian: Bool = false

	var filteredChartData: [ChartData] {
		return showCongressMedian ? chartData : chartData.filter { $0.party != "Congress" }
	}
	
	var range: ClosedRange<Date> {
		var components = DateComponents()
		components.day = 1
		components.month = 1
		components.year = 1945
		
		let beginning = Calendar.current.date(from: components)!
		
		var components2 = DateComponents()
		components2.day = 1
		components2.month = 1
		components2.year = 2030
		
		let end = Calendar.current.date(from: components2)!
		
		let range = beginning...end
		return range
	}
	
	var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				ChartTitle(headline: "Political ideology in Congress, 1948-2025", subheadline: "On average, Democrats and Republicans are farther apart ideologically today than at any time in the past 80 years.")
				
				Chart {
					ForEach(filteredChartData, id: \.self) { element in
						LineMark(
							x: .value("DW-NOMINATE Score", element.median),
							y: .value("Congress", Congress.findCase(for: element.congress).convertToYear()),
							series: .value("Party", element.party)
						)
						.foregroundStyle(by: .value("Party", element.party))
						.interpolationMethod(.catmullRom)
					}
				}
				.chartLegend(position: .top, spacing: 16)
				.chartForegroundStyleScale(
					domain: showCongressMedian ? ["Democrats", "Republicans", "Congress"] : ["Democrats", "Republicans"],
					range: showCongressMedian ? [.blue, .red, .gray] : [.blue, .red]
				)
				.chartYAxis {
					AxisMarks(position: .leading, values: .automatic(desiredCount: 10))
				}
				.chartXAxisLabel(position: .bottom, alignment: .center) {
					HStack {
						Image(systemName: "arrow.left")
						Text("More Liberal")
						Spacer(minLength: 80)
						Text("More Conservative")
						Image(systemName: "arrow.right")
					}
					.fontWeight(.medium)
					.offset(x: 17)
				}
				.chartYScale(domain: range)
				.chartXScale(domain: -0.6...0.6)
				.aspectRatio(1, contentMode: .fit)
				.padding(.vertical)
				
				Toggle(isOn: $showCongressMedian.animation()) {
					Text("Show Congress median")
						.fontWeight(.medium)
				}
				
				ChartFootnote {
					Text("Using the median DW-NOMINATE score from each major party in Congress, we can track how the parties have shifted over time. In general, Republicans have moved further to the right than Democrats have to the left.")
						.padding(.bottom, 6)
					Text("The congressional median (gray line) swings back and forth as the balance of power in the House and Senate changes.")
				}
				.padding(.bottom, 8)
				
				ChartSources(sources: [CustomURL(pageTitle: "Parties at a Glance", siteTitle: "Voteview", url: "https://voteview.com/parties/all")])
			}
		}
		.contentMargins(.horizontal, 16, for: .scrollContent)
		.navigationTitle("Chart")
		.navigationBarTitleDisplayMode(.inline)
	}
}

#Preview {
	ChartView(chartData: [])
}
