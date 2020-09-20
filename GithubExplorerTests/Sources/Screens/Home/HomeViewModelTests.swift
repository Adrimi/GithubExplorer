//
//  HomeViewModelTests.swift
//  GithubExplorerTests
//
//  Created by adrian.szymanowski on 18/09/2020.
//

import Foundation
import XCTest
import Combine
@testable import GithubExplorer

class HomeViewModelTests: XCTestCase {
    
    func test_initialState_searchWithoutSuggestions() {
        let (sut, search) = makeSUT()
        let state = StateSpy(sut.state)
        
        XCTAssertEqual(state.values, [.field(search)])
    }
    
    func test_searchTextChangeState_providesSuggestionsBasedOnText() {
        let service = SuggestionsServiceStub()
        let (sut, search) = makeSUT(service: service)
        let state = StateSpy(sut.state)
        
        search.text.send(service.stub.query)
        
        XCTAssertEqual(state.values, [
            .field(search),
            .fieldWithSuggestions(search, service.stub.suggestions.map(SuggestionViewModel.init))
        ])
    }
    
    func test_searchTextChangeState_hideSuggestionOnEmptyText() {
        let service = SuggestionsServiceStub()
        let (sut, search) = makeSUT(service: service)
        let state = StateSpy(sut.state)
        
        search.text.send(service.stub.query)
        search.text.send("")
        
        XCTAssertEqual(state.values, [
            .field(search),
            .fieldWithSuggestions(search, service.stub.suggestions.map(SuggestionViewModel.init)),
            .field(search)
        ])
    }
    
    func test_searchSuggestionSelectedState_includeSearchField() {
        let service = SuggestionsServiceStub()
        let (sut, search) = makeSUT(service: service)
        let state = StateSpy(sut.state)
        
        search.text.send(service.stub.query)
        
        switch state.values.last {
        case let .fieldWithSuggestions(_, suggestions) where !suggestions.isEmpty:
            suggestions.first?.select.send(())
        default:
            XCTFail("Expected suggestions in the current state")
        }
        
        XCTAssertEqual(state.values, [
            .field(search),
            .fieldWithSuggestions(search, service.stub.suggestions.map(SuggestionViewModel.init)),
            .field(search)
        ])
    }

    // MARK: makeSUT
    private func makeSUT(service: SuggestionsServiceStub = .init()) -> (HomeViewModel, FieldViewModel) {
        let search = FieldViewModel(text: "test")
        let sut = HomeViewModel(search: search, service: service)
            
        return (sut, search)
    }
    
    // MARK: Tests abstractions
    class StateSpy {
        private(set) var values: [HomeViewModel.State] = []
        private var cancellables = Set<AnyCancellable>()
        init(_ publisher: AnyPublisher<HomeViewModel.State, Never>) {
            publisher.sink { [weak self] state in
                self?.values.append(state)
            }
            .store(in: &cancellables)
        }
    }
    
    class SuggestionsServiceStub: SuggestionsService {
        let stub = (query: "a query",
                    suggestions: [
                        SuggestionModel(id: 0, login: "adrimi", avatarURL: ""),
                        SuggestionModel(id: 1, login: "uPaid", avatarURL: "")])
        
        func perform(request: SuggestionsRequest) -> Just<[SuggestionModel]> {
            Just(request.query == stub.query ? stub.suggestions : [])
        }
    }
}


class SuggestionViewModelTests: XCTestCase {
    func test_text_isBasedOnProvidedSuggestionValues() {
        let suggestion = SuggestionModel(id: 0, login: "adrimi", avatarURL: "google.com")
        
        let sut = SuggestionViewModel(suggestion)
        
        XCTAssertEqual(sut.text, suggestion.login)
    }
}
