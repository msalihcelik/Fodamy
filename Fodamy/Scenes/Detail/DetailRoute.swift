//
//  DetailRoute.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 24.03.2022.
//

protocol DetailRoute {
    func pushDetail(recipeId: Int)
}

extension DetailRoute where Self: RouterProtocol {
    
    func pushDetail(recipeId: Int) {
        let router = DetailRouter()
        let viewModel = DetailViewModel(recipeId: recipeId, router: router)
        let viewController = DetailViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
