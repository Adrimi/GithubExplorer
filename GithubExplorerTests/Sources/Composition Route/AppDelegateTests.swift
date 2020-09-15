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
    
    // MARK: Parameters
    private var sut: AppDelegate!
    private var launchResult: Bool!
    
    // MARK: Setup
    override func setUpWithError() throws {
        sut = AppDelegate()
        launchResult = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Tests
    func test_applicationSouldLaunch_withTrueValue() {
        XCTAssertTrue(launchResult)
    }
    
}
