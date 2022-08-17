//
//  TabBarController.swift
//  Maps
//
//  Created by Artem Serebriakov on 17.08.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

//    lazy var mapVC = MapViewController()
    lazy var vc1 = UINavigationController(rootViewController: MapViewController())
    lazy var vc2 = UINavigationController(rootViewController: ListViewController())
    lazy var vc3 = UINavigationController(rootViewController: MoreViewController())

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewControllers([vc1, vc2, vc3], animated: false)
        guard let items = tabBar.items else { return }
        
        let images = ["map", "list.star", "ellipsis"]
        let title = ["Map", "List", "More"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
            items[i].title = title[i]
            items[i].badgeValue = "1"
        }
        
        modalPresentationStyle = .fullScreen
        // Do any additional setup after loading the view.
    }
}


