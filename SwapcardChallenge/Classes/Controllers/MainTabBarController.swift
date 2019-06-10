//
//  MainTabBarController.swift
//  SwapcardChallenge
//
//  Created by Axel Drozdzynski on 12/05/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIHelper.Color.whiteSmokeColor
        tabBar.tintColor = UIHelper.Color.greenSwapcard
        tabBar.unselectedItemTintColor = .black
        setupTabBar()
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.isOpaque = false
        self.tabBarController?.tabBar.barStyle = UIBarStyle.blackTranslucent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.resizeIcons()
    }
    
    private func setupTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let usersListVC = storyboard.instantiateViewController(withIdentifier: "usersListVC")
        let tab1 = UINavigationController(rootViewController: usersListVC)
        tab1.tabBarItem.image = UIImage(named: "ic-contact")
        tab1.tabBarItem.image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        tab1.tabBarItem.selectedImage = UIImage(named: "ic-contact")
        tab1.tabBarItem.selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let favorisVC = storyboard.instantiateViewController(withIdentifier: "favorisVC")
        let tab2 = UINavigationController(rootViewController: favorisVC)
        tab2.tabBarItem.image = UIImage(named: "ic-favori")
        tab2.tabBarItem.image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        tab2.tabBarItem.selectedImage = UIImage(named: "ic favori")
        tab2.tabBarItem.selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        self.viewControllers = [tab1, tab2]
    }
    
    // Resize icons in fonction of height screen
    private func resizeIcons() {
        if let items = tabBar.items {
            for item in items {
                if (UIHelper.isAtLeastDeviceType(deviceType: .iphoneX)) {
                    item.imageInsets = UIEdgeInsets(top: 14, left: 0, bottom: -4, right: 0)
                    print("iphone X")
                } else {
                    item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
                    print("iphone 6")
                }
            }
        }
    }
}
