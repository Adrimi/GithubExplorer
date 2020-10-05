//
//  HomeViewModel.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 18/09/2020.
//

import Combine

struct FieldViewModel: Equatable, Hashable {
    private(set) var text: CurrentValueSubject<String, Never> = .init("")
    
    init(text: String) {
        self.text = .init(text)
    }
    
    static func == (lhs: FieldViewModel, rhs: FieldViewModel) -> Bool {
        lhs.text.value == rhs.text.value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text.value)
    }
}

struct SuggestionViewModel: Equatable, Hashable {
    let id: Int
    let text: String
    let imageURL: String
    let select: PassthroughSubject<Void, Never>
    
    init(_ suggestion: SuggestionModel) {
        self.init(suggestion, select: .init())
    }
    
    init(_ suggestion: SuggestionModel, select: PassthroughSubject<Void, Never>) {
        self.id = suggestion.id
        self.text = suggestion.login
        self.imageURL = suggestion.avatarURL
        self.select = select
    }
    
    static func == (lhs: SuggestionViewModel, rhs: SuggestionViewModel) -> Bool {
        lhs.text == rhs.text && lhs.imageURL == rhs.imageURL
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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
        if #available(iOS 14.0, *) {
            return field.text
                .dropFirst(1)
                .removeDuplicates()
                .flatMap { [service] query in
                    service.perform(request: .init(query: query))
                }
                .catch { error -> Just<[SuggestionModel]> in
                    Just([])
                }
                .map { [search, suggestionSelection] suggestions -> HomeViewModel.State in
                    if suggestions.isEmpty {
                        return .field(search)
                    }
                    return .fieldWithSuggestions(search, suggestions.map { suggestion in
                        SuggestionViewModel(suggestion, select: suggestionSelection)
                    })
                }
                .eraseToAnyPublisher()
        } else {
            return Just(State.field(search))
                .eraseToAnyPublisher()
        }
    }
}


