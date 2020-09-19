//
//  SuggestionsService.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 19/09/2020.
//

import Combine

protocol SuggestionsService {
    func perform(request: SuggestionsRequest) -> Just<[SuggestionModel]>
}
