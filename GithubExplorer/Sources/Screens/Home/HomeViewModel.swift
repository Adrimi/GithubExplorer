//
//  HomeViewModel.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 18/09/2020.
//

import UIKit
import Combine

struct FieldViewModel: Equatable {
    static func == (lhs: FieldViewModel, rhs: FieldViewModel) -> Bool {
        true
    }
    
    private(set) var text: CurrentValueSubject<String, Never> = .init("")
}

struct SuggestionViewModel: Equatable {
    var select = PassthroughSubject<Void, Never>()
    
    init(_ suggestion: SuggestionModel) {
        self.init(suggestion, select: .init())
    }
    
    init(_ suggestion: SuggestionModel, select: PassthroughSubject<Void, Never>) {
        self.select = select
    }
    
    static func == (lhs: SuggestionViewModel, rhs: SuggestionViewModel) -> Bool {
        true
    }
}

class HomeViewModel {
    
    // MARK: State
    enum State: Equatable {
        case field(FieldViewModel)
        case fieldWithSuggestions(FieldViewModel, [SuggestionViewModel])
    }
    
    var state: AnyPublisher<State, Never> {
        Just(.field(search))
            .merge(with:
                search(for: search),
                   suggestionSelection.map { [search] in
                        .field(search)
                   })
            .eraseToAnyPublisher()
    }
    
    // MARK: Params
    private let search: FieldViewModel
    private let suggestionSelection = PassthroughSubject<Void, Never>()
    private let service: SuggestionsService
    
    // MARK: Inits
    init(search: FieldViewModel, service: SuggestionsService) {
        self.search = search
        self.service = service
    }
    
    // MARK: Helper methods
    private func search(for field: FieldViewModel) -> AnyPublisher<State, Never> {
        field.text
            .dropFirst(1)
            .removeDuplicates()
            .flatMap { [service] query in
                service.perform(request: .init(query: query))
            }.map { [search, suggestionSelection] suggestions in
                if suggestions.isEmpty {
                    return .field(search)
                } else {
                    return .fieldWithSuggestions(search, suggestions.map { suggestion in
                        SuggestionViewModel(suggestion, select: suggestionSelection)
                    })
                }
            }
            .eraseToAnyPublisher()
    }
}


