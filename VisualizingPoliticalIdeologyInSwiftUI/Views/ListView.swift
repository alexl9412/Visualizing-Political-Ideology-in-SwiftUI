//
//  ListView.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/15/25.
//

import SwiftUI

struct ListView: View {
	@State private var appState: AppState = .idle
	@State private var data: [DWNominateScore] = []

	var body: some View {
		NavigationStack {
			switch appState {
			case .idle:
				List {
					ForEach(data) { row in
						HStack {
							VStack(alignment: .leading) {
								Text("Congress: \(row.congress)")
								Text("Chamber: \(row.chamber)")
								Text("Party: \(row.partyCode)")
							}
							Spacer()
							if let score = row.nominateDim1 {
								Text("\(score, specifier: "%.3f")")
							}
						}
					}
				}
				.navigationTitle("DW-NOMINATE Scores")
			case .loading:
				ProgressView()
			}
		}
		.task {
			do {
				appState = .loading
				defer { appState = .idle }

				data = try await fetchData()
				
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
}

#Preview {
    ListView()
}
