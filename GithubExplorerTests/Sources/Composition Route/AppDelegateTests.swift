//
//  AppDelegateTests.swift
//  GithubExplorerTests
//
//  Created by adrian.szymanowski on 15/09/2020.
//

import UIKit
import XCTest
@testable import GithubExplorer

class AppDelegateTests: XCTestCase {
    
    // MARK: - Tests
    func test_applicationSouldLaunch_withTrueValue() {
        let sut = AppDelegate()
        let launchResult = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        XCTAssertTrue(launchResult)
    }
    
}
