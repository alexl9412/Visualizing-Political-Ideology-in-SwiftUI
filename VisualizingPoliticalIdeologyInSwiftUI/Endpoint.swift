//
//  Endpoint.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/13/25.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var httpMethod: HttpMethod { get }
    var header: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
}

enum HttpMethod: String {
    case get = "GET"
}
