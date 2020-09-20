//
//  GithubUserSuggestionsResponse.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 20/09/2020.
//

import Foundation

struct GithubUserSuggestionsResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [SuggestionModel]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
