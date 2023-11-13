//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Киса Мурлыса on 02.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        
        let viewController = LounchViewController()
        viewController.view.backgroundColor = .white
        let navViewController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navViewController
    }
}

