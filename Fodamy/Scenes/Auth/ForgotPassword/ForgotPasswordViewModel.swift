//
//  ForgotPasswordViewModel.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

protocol ForgotPasswordViewDataSource {}

protocol ForgotPasswordViewEventSource {}

protocol ForgotPasswordViewProtocol: ForgotPasswordViewDataSource, ForgotPasswordViewEventSource {
    func resetButtonTapped(email: String)
}

final class ForgotPasswordViewModel: BaseViewModel<ForgotPasswordRouter>, ForgotPasswordViewProtocol {
    
    func resetButtonTapped(email: String) {
        showLoading?()
        let request = ForgotPasswordRequest(email: email)
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideLoading?()
            switch result {
            case.success(_):
                print(L10n.Forgot.success)
            case.failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
}
