//
//  NetworkingDataService.swift
//  Friendji
//
//  Created by Kasra Abasi on 8/3/19.
//  Copyright © 2019 kasraabasi. All rights reserved.
//

/// This is singelton responsible for sending HTTP request and parsing the response when web service api and backend is ready
/// it also have a decodeJSONFromFile for moking fake requests

import Foundation

class NetworkingDataService {
    
    // MARK: - Inner Types
    enum DecodeResult<T> {
        case success(T)
        case failure(NetworkingDataServiceError)
    }
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    enum NetworkingDataServiceError: String, Error, LocalizedError {
        case invalidURL
        case decodeFailed
        case statusCodeNot200
        case invalidPayload
        var errorDescription: String? { return NSLocalizedString((self.rawValue), comment: "") }
    }
    typealias JSON = [String: Any]
    
    
    
    // MARK: - Properties
    static let shared = NetworkingDataService()
    
    
    
    // MARK: - Initializers
    private init(){}
    
    
    
    // MARK: - Methods
    func decodeJSONFromFile<T: Decodable>(fileName: String, for: T.Type = T.self, completion: @escaping (DecodeResult<T>) -> Void) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            completion(.failure(.invalidURL))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            DispatchQueue.main.async {
                completion(.success(jsonData))
            }
        } catch let error {
            print(error)
            completion(.failure(.decodeFailed))
        }
    }
    func sendHTTPRequest<T: Decodable>(for: T.Type = T.self, url: String, method: RequestMethod, body: JSON? = nil, token: String? = nil, completion: @escaping (DecodeResult<T>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        let urlRequest = NSMutableURLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token  {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        urlRequest.timeoutInterval = 10.0
        if let body = body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest as URLRequest) { data, response, error in
            let status = (response as? HTTPURLResponse)?.statusCode ?? -1
            DispatchQueue.main.async {
                if status == 200 {
                    guard let data = data else {
                        return completion(.failure(.invalidPayload))
                    }
                    do {
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode(T.self, from: data)
                        completion(.success(jsonData))
                    } catch let decodingError {
                        print(decodingError)
                        completion(.failure(.decodeFailed))
                    }
                } else {
                    completion(.failure(.statusCodeNot200))
                }
            }
        }
        task.resume()
    }
   
}

