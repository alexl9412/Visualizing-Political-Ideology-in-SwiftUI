//
//  DWNominateService.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/13/25.
//

import Foundation

class DWNominateService {
	let manager = NetworkManager(keyDecodingStrategy: .convertFromSnakeCase)
    
    enum DWNominateRoute: Endpoint {
        case route(DataType, Chamber, Congress, FileType)
        
        enum DataType: String {
            case memberIdeology = "members"
            case congressionalVotes = "rollcalls"
            case membersVotes = "votes"
            case congressionalParties = "parties"
        }
        
        enum Chamber: String {
            case houseAndSenate = "HS"
            case house = "H"
            case senate = "S"
        }
        
        enum Congress {
            case all
            case specificCongress(Int)
            
            var path: String {
                switch self {
                case .all: return "all"
                case .specificCongress(let congress):
					switch congress {
					case 1...9: return "00\(congress)"
					case 10...99: return "0\(congress)"
					default: return "\(congress)"
					}
                }
            }
        }
        
        enum FileType: String {
            case json = "json"
            case csv = "csv"
        }
        
        var host: String {
            return "voteview.com"
        }
        
        var httpMethod: HttpMethod {
            return .get
        }
        
        var header: [String : String]? {
            return nil
        }
        
        var path: String {
            switch self {
            case .route(let type,let chamber, let congress, let fileType):
				return "/static/data/out/\(type.rawValue)/\(chamber.rawValue)\(congress.path)_\(type.rawValue).\(fileType.rawValue)"
            }
        }
        
        var queryItems: [URLQueryItem]? {
            return nil
        }
    }
    
	func fetchDWNominateScores(dataType: DWNominateRoute.DataType, chamber: DWNominateRoute.Chamber, congress: DWNominateRoute.Congress, fileType: DWNominateRoute.FileType) async throws -> [DWNominateScore]? {
		return try await manager.loadCSVData(endpoint: DWNominateRoute.route(dataType, chamber, congress, fileType), decodeTo: [DWNominateScore].self)
    }
}
