//
//  LoginViewModel.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

protocol LoginViewDataSource {}

protocol LoginViewEventSource {}

protocol LoginViewProtocol: LoginViewDataSource, LoginViewEventSource {
    func pushPasswordResetScene()
    func signInButtonTapped(email: String, password: String)
    func signUpButtonTapped()
}

final class LoginViewModel: BaseViewModel<LoginRouter>, LoginViewProtocol {
    
    private let keychain = KeychainSwift()
    
    func pushPasswordResetScene() {
        router.pushForgotPassword()
    }
    
    func signInButtonTapped(email: String, password: String) {
        showLoading?()
        dataProvider.request(for: LoginRequest(username: email, password: password)) { [weak self] result in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case .success(let response):
                self.keychain.set(response.token, forKey: Keychain.token)
                DefaultsKey.userId.value = response.user.id
                self.sendNotification()
                self.router.close()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
    
    func signUpButtonTapped() {
        router.pushRegister()
    }
    
    func sendNotification() {
        NotificationCenter.default.post(name: .init(rawValue: "reloadData"), object: nil)
    }
}
