//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 28.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Public Properties
    var window: UIWindow?

    // MARK: - Public Methods

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController(rootViewController: MainMenuViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
