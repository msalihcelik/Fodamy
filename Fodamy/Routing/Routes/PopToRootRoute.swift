//
//  PopToRootRoute.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

protocol PopToRootRoute {
    func popToRoot(isAnimated: Bool)
}

extension PopToRootRoute where Self: RouterProtocol {
    
    func popToRoot(isAnimated: Bool = true) {
        guard let navigationController = viewController?.navigationController else {
            return
        }
        navigationController.popToRootViewController(animated: isAnimated)
    }
}
