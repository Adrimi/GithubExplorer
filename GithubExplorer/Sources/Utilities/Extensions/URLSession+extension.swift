//
//  URLSession+extension.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 20/09/2020.
//

import Combine
import Foundation

extension URLSession {
    func publisher<T: Decodable>(
        for url: URL,
        responseType: T.Type = T.self,
        decoder: JSONDecoder = .init()
    ) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

