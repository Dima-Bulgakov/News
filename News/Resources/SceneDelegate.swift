//
//  SceneDelegate.swift
//  News
//
//  Created by Dima on 05.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navVC = UINavigationController(rootViewController: MainViewController())
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}

