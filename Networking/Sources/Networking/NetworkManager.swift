//
//  NetworkManager.swift
//  Networking
//
//  Created by Єва Матвєєва on 26.05.2025.
//

import Foundation

public class NetworkManager {
    
    public enum NetworkError: Error {
        case noData
        case invalidURL
        
    }
    
    private init() {}
    
    private static let urlBaseCats = "https://api.thecatapi.com/v1/images/search?limit="
    private static let API_KEY_CATS = "live_iyyEovDFiqOJ6OM8Wox5S5bJZ0P0JrC7En3JfrVKLT9NSHihgMPV7baZbop4ggTa"
    
    private static let urlBaseDogs = "https://api.thedogapi.com/v1/images/search?limit="
    private static let API_KEY_DOGS = "live_CeKcvuvj2kzLPGkXprj9Cwg72p43WizYvSPhmGjnH6lUF49W3yi1qERkIK1mQGbh"
    
    public static func getCats(limit: Int, completion: @escaping (Result<[String], Error>) -> Void) {
        
        guard var urlComponents = URLComponents(string: urlBaseCats) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "api_key", value: API_KEY_CATS)
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let cats = try JSONDecoder().decode([Cat].self, from: data)
                let urls = cats.map { $0.url }
                completion(.success(urls))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        } .resume()
    }
    
    public static func getDogs(limit: Int, completion: @escaping (Result<[String], Error>) -> Void) {
        
        guard var urlComponents = URLComponents(string: urlBaseDogs) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "api_key", value: API_KEY_DOGS)
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let cats = try JSONDecoder().decode([Cat].self, from: data)
                let urls = cats.map { $0.url }
                completion(.success(urls))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        } .resume()
    }
}

//extension NetworkManager {
//    public static func getCatsAsync(limit: Int) async throws -> [String] {
//        return try await withCheckedThrowingContinuation { continuation in
//            getCats(limit: limit) { result in
//                switch result {
//                case .success(let urls):
//                    continuation.resume(returning: urls)
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
//}
