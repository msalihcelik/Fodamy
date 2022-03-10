//
//  MainTabBarRoute.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 10.03.2022.
//

protocol MainTabBarRoute {
    func placeOnWindowMainTabBar()
}

extension MainTabBarRoute where Self: RouterProtocol {
    
    func placeOnWindowMainTabBar() {
        let mainTabBarController = MainTabBarController()
        let transition = PlaceOnWindowTransition()
        
        open(mainTabBarController, transition: transition)
    }
}
