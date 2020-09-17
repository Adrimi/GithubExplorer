//
//  SceneDelegateTests.swift
//  GithubExplorerTests
//
//  Created by adrian.szymanowski on 16/09/2020.
//

import UIKit
import XCTest
@testable import GithubExplorer

class SceneDelegateTests: XCTestCase {
    
    // MARK: Tests
    func test_shouldSetWindow_fromFactory() {
        let (sut, windowFactory, _) = makeSUT()
        
        XCTAssertTrue(sut.window === windowFactory.stubbedWindow)
    }
    
    func test_shouldSetRootController_fromFactory() {
        let (sut, windowFactory, rootControllerFacotry) = makeSUT()
        sut.setWindow()
        XCTAssertEqual(windowFactory.capturedController, rootControllerFacotry.mainController())
    }
    
    // MARK: Helpers
    private func makeSUT() -> (SceneDelegate, WindowFactorySpy, RootControllerFactoryStub) {
        let windowFactory = WindowFactorySpy()
        let rootControllerFactory = RootControllerFactoryStub()
        let sut = SceneDelegate(windowFactory: windowFactory, rootControllerFactory: rootControllerFactory)
        
        return (sut, windowFactory, rootControllerFactory)
    }
}
