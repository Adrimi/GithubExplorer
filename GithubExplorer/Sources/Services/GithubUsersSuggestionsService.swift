//
//  GithubUsersSuggestionsService.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 20/09/2020.
//

import Combine
import Foundation


class GithubUserSuggestionsService: SuggestionsService {
    func perform(request: SuggestionsRequest) -> Just<[SuggestionModel]> {
        let dataTaskPublisher: AnyPublisher<GithubUserSuggestionsResponse, Error> = URLSession.shared
            .dataTaskPublisher(for: Self.buildURL(from: request))
        let test1 = dataTaskPublisher
            .map(\.items)
            .compactMap { suggestions in
                Just(suggestions)
            }
        return Just([])
//        return test1
    }
    
    static func buildURL(from request: SuggestionsRequest) -> URL {
        var urlComponents = URLComponents(string: "https://api.github.com/search/users")
        var queryParams = [URLQueryItem]()
        queryParams.append(.init(name: "q", value: request.query))
        
        urlComponents?.queryItems = queryParams
        let url = urlComponents!.url!
        return url
    }
}

