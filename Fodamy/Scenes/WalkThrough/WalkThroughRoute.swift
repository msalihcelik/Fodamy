//
//  WalkThroughRoute.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 9.03.2022.
//

protocol WalkThroughRoute {
    func placeOnWindowWalkThrough()
}

extension WalkThroughRoute where Self: RouterProtocol {
    
    func placeOnWindowWalkThrough() {
        let router = WalkThroughRouter()
        let viewModel = WalkThroughViewModel(router: router)
        let viewController = WalkThroughViewController(viewModel: viewModel)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
