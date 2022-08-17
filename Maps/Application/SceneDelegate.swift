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
        let vc = ViewController()
        window?.rootViewController = vc
        
        window?.makeKeyAndVisible()
    }


}

