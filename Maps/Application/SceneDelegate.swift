//
//  SceneDelegate.swift
//  Maps
//
//  Created by Artem Serebriakov on 17.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let tbc = MainTabBarController()
        tbc.tabBar.barTintColor = .systemBackground
        tbc.selectedIndex = 0
        window?.rootViewController = tbc
        
        window?.makeKeyAndVisible()
    }


}

