//
//  URLSession+extension.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 20/09/2020.
//

import Combine
import Foundation

extension URLSession {
    enum SessionError: Error {
        case statusCode(HTTPURLResponse)
    }
    
    func dataTaskPublisher<T: Decodable>(for url: URL) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                if let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) == false {
                    throw SessionError.statusCode(response)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

