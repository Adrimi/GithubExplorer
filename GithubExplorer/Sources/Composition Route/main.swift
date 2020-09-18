//
//  main.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 18/09/2020.
//

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("GithubExplorerTests.AppDelegateStub") ?? AppDelegate.self

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(appDelegateClass))
