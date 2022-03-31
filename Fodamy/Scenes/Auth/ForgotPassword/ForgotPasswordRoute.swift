//
//  ForgotPasswordRoute.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

protocol ForgotPasswordRoute {
    func pushForgotPassword()
}

extension ForgotPasswordRoute where Self: RouterProtocol {
    
    func pushForgotPassword() {
        let router = ForgotPasswordRouter()
        let viewModel = ForgotPasswordViewModel(router: router)
        let viewController = ForgotPasswordViewController(viewModel: viewModel)
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
