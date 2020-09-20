//
//  MainRootControllerFacotry.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 17/09/2020.
//

import UIKit
import Combine

class MainRootControllerFacory: RootControllerFactory {
    func mainController() -> UIViewController {
        let service = GithubUserSuggestionsService()
        let viewModel = HomeViewModel(search: FieldViewModel(text: "Search"),
                                      service: service)
        let viewController = HomeViewController(viewModel: viewModel)
        
        let navigationController = UINavigationController()
        
        navigationController.addChild(viewController)
        return navigationController
    }
}

//class RandomSuggestionsService: SuggestionsService {
//    func perform(request: SuggestionsRequest) -> Just<[SuggestionModel]> {
//        Just((0...10).map { _ -> SuggestionModel in SuggestionModel(id: Int.random(in: 0...99999999),
//                                            login: "\(Int.random(in: 0...99999999))",
//                                            avatarURL: "") })
//    }
//}
