//
//  BaseTabBarController.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 3.02.2023.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = createViewControllers()
        tabBar.tintColor = .label
        tabBar.backgroundColor = .tertiarySystemGroupedBackground
        tabBar.isTranslucent = false
        tabBar.tintColor = .link
    }
    
    private func createViewControllers() -> [UIViewController] {
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.tabBarItem = .init(title: "Search", image: .init(systemName: ImageManager.iconSearch), tag: 2)
        searchVC.navigationBar.prefersLargeTitles = true
        let appsVC = UINavigationController(rootViewController: AppsViewController())
        appsVC.tabBarItem = .init(title: "Apps", image: .init(systemName: ImageManager.iconApps), tag: 1)
        appsVC.navigationBar.prefersLargeTitles = true
        let todayVC = UINavigationController(rootViewController: TodayViewController())
        todayVC.tabBarItem = .init(title: "Today", image: .init(systemName: ImageManager.iconToday), tag: 0)
        todayVC.navigationBar.prefersLargeTitles = true
        
        return [
            searchVC,
            todayVC,
            appsVC
        ]
    }
}

