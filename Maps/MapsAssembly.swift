//
//  MapsAssembly.swift
//  Maps
//
//  Created by Artem Serebriakov on 17.08.2022.
//

import Foundation

import UIKit

protocol IMapsAssembly {
    
    func assemble() -> UITabBarController
}

final class MapsAssembly: IMapsAssembly {
   
    func assemble() -> UITabBarController {
        let mainTabBarController = MainTabBarController()
        let vc1 = MapViewController()
        let vc2 = ListViewController()
        let vc3 = MoreViewController()
        
        vc2.delegate = vc1
        
//        let nvc1 = UINavigationController(rootViewController: vc1)
//        let nvc2 = UINavigationController(rootViewController: vc2)
//        let nvc3 = UINavigationController(rootViewController: vc3)

        mainTabBarController.setViewControllers([vc1, vc2, vc3], animated: false)
        guard let items = mainTabBarController.tabBar.items else {
            return mainTabBarController
        }
        
        let images = ["map", "list.star", "ellipsis"]
        let title = ["Map", "List", "More"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
            items[i].title = title[i]
//            items[i].badgeValue = "1"
        }
        
        mainTabBarController.tabBar.backgroundColor = .systemBackground
        mainTabBarController.selectedIndex = 0
        mainTabBarController.modalPresentationStyle = .fullScreen
        UITabBar.appearance().barTintColor = .systemBackground
        
        
        return mainTabBarController
    }
}
