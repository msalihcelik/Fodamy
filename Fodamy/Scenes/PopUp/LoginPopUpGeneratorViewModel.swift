//
//  LoginPopUpGeneratorViewModel.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 26.03.2022.
//

protocol LoginPopUpGeneratorViewDataSource {}

protocol LoginPopUpGeneratorViewEventSource {
    var loginHandler: VoidClosure? { get set }
}

protocol LoginPopUpGeneratorViewProtocol: LoginPopUpGeneratorViewDataSource, LoginPopUpGeneratorViewEventSource {
    func giveUpButtonAction()
    func loginButtonAction()
}

final class LoginPopUpGeneratorViewModel: BaseViewModel<LoginPopUpGeneratorRouter>, LoginPopUpGeneratorViewProtocol {
    var loginHandler: VoidClosure?
    
    func giveUpButtonAction() {
        router.close()
    }
    func loginButtonAction() {
        router.close()
        loginHandler?()
    }
    
}
