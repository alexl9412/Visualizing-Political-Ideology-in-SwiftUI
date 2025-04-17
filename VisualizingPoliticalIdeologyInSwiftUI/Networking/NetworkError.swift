//
//  NetworkError.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/13/25.
//

import Foundation

enum NetworkError: Error {
    case noNetworkAvailable
    case failedToDecode(url: URL)
    case invalidURL(url: URL?)
    case invalidStatusCode(url: URL, statusCode: Int?)
    case custom(url: URL, error: Error)
}
