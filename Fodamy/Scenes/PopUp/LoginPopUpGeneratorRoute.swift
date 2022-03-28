//
//  LoginPopUpGeneratorRoute.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 26.03.2022.
//

protocol LoginPopUpGeneratorRoute {
    func presentLoginPopUpGenerator(loginHandler: @escaping VoidClosure)
}

extension LoginPopUpGeneratorRoute where Self: RouterProtocol {
    
    func presentLoginPopUpGenerator(loginHandler: @escaping VoidClosure) {
        let router = LoginPopUpGeneratorRouter()
        let viewModel = LoginPopUpGeneratorViewModel(router: router)
        let viewController = LoginPopUpGeneratorViewController(viewModel: viewModel)
        viewModel.loginHandler = loginHandler

        let transition = ModalTransition()
        transition.modalPresentationStyle = .overFullScreen
        transition.modalTransitionStyle = .crossDissolve
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
