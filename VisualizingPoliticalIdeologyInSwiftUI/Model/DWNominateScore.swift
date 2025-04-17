//
//  DWNominateScores.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/13/25.
//

import Foundation

struct DWNominateScore: Identifiable, Codable {
    let icpsr: Int
    let congress: Int
    let chamber: String
    let partyCode: Int
    let bioname: String
    let nominateDim1: Double?

    var id: Int { icpsr }
    
    enum CodingKeys: String, CodingKey {
        case icpsr
        case congress
        case chamber
        case partyCode = "party_code"
        case bioname
        case nominateDim1 = "nominate_dim1"
    }
}
