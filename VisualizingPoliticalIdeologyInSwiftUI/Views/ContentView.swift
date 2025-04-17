//
//  ContentView.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/13/25.
//

import SwiftUI
import Charts

struct ContentView: View {
	@State private var appState: AppState = .idle
	@State private var chartData: [ChartData] = []

    var body: some View {
		NavigationStack {
			switch appState {
			case .idle:
				ChartView(chartData: chartData)
					.transition(.opacity)
			case .loading:
				ProgressView()
			}
		}
		.task {
			do {
				appState = .loading
				defer {
					withAnimation { appState = .idle }
				}

				let data = try await fetchData()
				
				chartData = await getChartData(data: data)
			} catch {
				print("Error: \(error)")
			}
		}
    }
	
	nonisolated private func fetchData() async throws -> [DWNominateScore] {
		let service = DWNominateService()
		let result = try await service.fetchDWNominateScores(dataType: .memberIdeology, chamber: .houseAndSenate, congress: .all, fileType: .csv) ?? []
		return result.filter { $0.congress >= 80 && ($0.partyCode == 100 || $0.partyCode == 200) && $0.chamber != "President" }
	}
	
	nonisolated private func getChartData(data: [DWNominateScore]) async -> [ChartData] {
		var array = [ChartData]()
		
		let demScores = data.filter { $0.partyCode == 100 }
		let repScores = data.filter { $0.partyCode == 200 }
		let congresses = Array(Set(data.map { $0.congress }))
		
		for congress in congresses {
			var demScoresDouble = demScores.filter { $0.congress == congress }.map { $0.nominateDim1 ?? 0 }
			let demMedian = demScoresDouble.findMedian()
			
			var repScoresDouble = repScores.filter { $0.congress == congress }.map { $0.nominateDim1 ?? 0 }
			let repMedian = repScoresDouble.findMedian()
			
			var congressScoresDouble = data.filter { $0.congress == congress }.map { $0.nominateDim1 ?? 0 }
			let congressMedian = congressScoresDouble.findMedian()
			
			let demResult = ChartData(id: UUID(), congress: congress, median: demMedian, party: "Democrats")
			let repResult = ChartData(id: UUID(), congress: congress, median: repMedian, party: "Republicans")
			let congressResult = ChartData(id: UUID(), congress: congress, median: congressMedian, party: "Congress")
			
			array.append(contentsOf: [demResult, repResult, congressResult])
			
		}
		return array.sorted { $0.congress < $1.congress }
	}
}

#Preview {
    ContentView()
}
