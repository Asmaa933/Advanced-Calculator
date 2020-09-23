//
//  SceneDelegate.swift
//  Advanced Calculator
//
//  Created by Esma on 9/19/20.
//  Copyright © 2020 Esma. All rights reserved.
//

import UIKit

/// Takes over some of the roles of the app delegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    /// Object of  backdrop for your app’s user interface and the object that dispatches events to your views.
    var window: UIWindow?
    
    /// Tells the delegate about the addition of a scene to the app.
    /// - Parameters:
    ///   - scene: The scene object being connected to your app.
    ///   - session: The session object containing details about the scene's configuration.
    ///   - connectionOptions: Additional options to use when configuring the scene. Use the information in this object to handle actions that caused the creation of the scene. For example, use it to respond to a quick action selected by the user.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        window?.rootViewController = CalculatorVC()
    }
}
