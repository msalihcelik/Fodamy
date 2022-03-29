//
//  BaseViewController.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 7.03.2022.
//

class BaseViewController<V: BaseViewModelProtocol>: UIViewController, BaseViewController.LoadingProtocols {
    
    typealias LoadingProtocols = LoadingProtocol & ActivityIndicatorProtocol
    
    private let retryButton = UIButtonBuilder()
        .backgroundColor(.appRed)
        .build()
    
    var viewModel: V
    
    init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // swiftlint:disable fatal_error unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error unavailable_function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appWhite
        subscribeLoading()
        subscribeActivityIndicator()
        subscribeToast()
        subscribeRetryButton()
    }
    
    private func subscribeRetryButton() {
        viewModel.showRetryButton = { [weak self] in
            guard let self = self else { return }
            let retryButton = RetryButton()
            self.view.addSubview(retryButton)
            retryButton.centerInSuperview()
            self.view.bringSubviewToFront(retryButton)
            retryButton.addTarget(self, action: #selector(self.retryButtonTapped), for: .touchUpInside)
        }
        
        viewModel.hideRetryButton = { [weak self] in
            guard let self = self else { return }
            self.view.subviews.filter({ $0 is RetryButton }).forEach({ $0.removeFromSuperview() })
        }
    }
    
    @objc
    private func retryButtonTapped() {
        viewModel.retryButtonTapped()
    }
    
    private func subscribeActivityIndicator() {
        viewModel.showActivityIndicatorView = { [weak self] in
            self?.showActivityIndicator()
        }
        viewModel.hideActivityIndicatorView = { [weak self] in
            self?.hideActivityIndicator()
        }
    }
    
    private func subscribeLoading() {
        viewModel.showLoading = { [weak self] in
            self?.presentLoading()
        }
        viewModel.hideLoading = { [weak self] in
            self?.dismissLoading()
        }
    }
    
    private func subscribeToast() {
        viewModel.showWarningToast = { text in
            ToastPresenter.showWarningToast(text: text)
        }
    }
    
    func showWarningToast(message: String) {
        ToastPresenter.showWarningToast(text: message)
    }
    
    #if DEBUG
    deinit {
        debugPrint("deinit \(self)")
    }
    #endif
    
}
