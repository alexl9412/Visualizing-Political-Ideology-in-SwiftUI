//
//  NetworkManager.swift
//  VisualizingPoliticalIdeologyInSwiftUI
//
//  Created by Alex Lenkei on 4/13/25.
//

import Foundation
import XMLCoder
import CodableCSV

final class NetworkManager {
    let keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    let dataDecodingStrategy: JSONDecoder.DataDecodingStrategy
    let dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    
	init(keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
		dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .base64,
		dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) {
        self.keyDecodingStrategy = keyDecodingStrategy
        self.dataDecodingStrategy = dataDecodingStrategy
        self.dateDecodingStrategy = dateDecodingStrategy
    }
    
    func loadData<T: Decodable>(endpoint: Endpoint, decodeTo: T.Type) async throws(NetworkError) -> T? {
        
        // construct URL from components
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        
        // check URL is valid
        guard let url = components.url else {
            throw NetworkError.invalidURL(url: components.url)
        }
        
        do {
            // fetch data
			let (data, response) = try await URLSession.shared.data(from: url)
            
            // check http response is valid
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                throw NetworkError.invalidStatusCode(url: url, statusCode: (response as? HTTPURLResponse)?.statusCode)
            }
                        
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = keyDecodingStrategy
            decoder.dataDecodingStrategy = dataDecodingStrategy
            decoder.dateDecodingStrategy = dateDecodingStrategy
            
            // decode response
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
            
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            throw NetworkError.failedToDecode(url: url)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            throw NetworkError.failedToDecode(url: url)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            throw NetworkError.failedToDecode(url: url)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            throw NetworkError.failedToDecode(url: url)
        } catch {
            throw NetworkError.failedToDecode(url: url)
        }
    }
    
    // generic XML decoding function, e.g., https://insideelections.com/developer
    func loadXMLData<T: Decodable>(endpoint: Endpoint, decodeTo: T.Type) async throws(NetworkError) -> T? {
        
        // construct URL from components
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path

        // check URL is valid
        guard let url = components.url else {
            throw NetworkError.invalidURL(url: components.url)
        }
        
        do {
            // fetch data
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // check http response is valid
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                throw NetworkError.invalidStatusCode(url: url, statusCode: (response as? HTTPURLResponse)?.statusCode)
            }
            
            let decodedResponse = try XMLDecoder().decode(T.self, from: data)
            return decodedResponse
			
        } catch {
            throw NetworkError.custom(url: url, error: error)
        }
    }
    
    // generic CSV decoding function for e.g., https://voteview.com/data
    func loadCSVData<T: Decodable>(endpoint: Endpoint, decodeTo: T.Type) async throws(NetworkError) -> T? {
        
        // construct URL from components
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path

        // check URL is valid
        guard let url = components.url else {
            throw NetworkError.invalidURL(url: components.url)
        }
        
        do {
            // fetch data
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // check http response is valid
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                throw NetworkError.invalidStatusCode(url: url, statusCode: (response as? HTTPURLResponse)?.statusCode)
            }
            
			let decoder = CSVDecoder {
				$0.headerStrategy = .firstLine
				$0.presample = false
				$0.bufferingStrategy = .sequential
			}
            let decodedResponse = try decoder.decode(T.self, from: data)

            return decodedResponse
        } catch {
            throw NetworkError.custom(url: url, error: error)
        }
    }
}
