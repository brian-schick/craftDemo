//
//  SceneDelegate.swift
//  intuitCraftDemo
//
//  Created by Brian Schick on 3/5/20.
//  Copyright © 2020 Brian Schick. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let _ = (scene as? UIWindowScene) else { return }
	}

	func sceneDidDisconnect(_ scene: UIScene) { }
	func sceneDidBecomeActive(_ scene: UIScene) { }
	func sceneWillResignActive(_ scene: UIScene) { }
	func sceneWillEnterForeground(_ scene: UIScene) { }
	func sceneDidEnterBackground(_ scene: UIScene) { }
}