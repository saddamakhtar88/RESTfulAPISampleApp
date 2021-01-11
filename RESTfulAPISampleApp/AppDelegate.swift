//
//  AppDelegate.swift
//  RESTfulAPISampleApp
//
//  Created by Saddam Akhtar on 1/11/21.
//

import UIKit
import DependencyRegistry

public typealias DI = DependencyRegistry

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    override init() {
        super.init()
        
        setupDependencies()
    }
    
    // MARK:- Dependency
    
    private func setupDependencies() {
        
        // Apply different env using schemes and preprocessor macros
        DI.register { () -> Environment in Development() }
        
        DI.register { () -> NetworkRouter in HTTPNetworkRouter(session: URLSession.shared) }
        DI.register { () -> NetworkResponseHandler in HTTPResponseHandler() }
        DI.register { () -> ImageSearchService in ImageSearchNetworkService() }
    }
}
