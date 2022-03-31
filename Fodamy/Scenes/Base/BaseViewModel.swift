//
//  BaseViewModel.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 7.03.2022.
//

protocol BaseViewModelDataSource: AnyObject {}

protocol BaseViewModelEventSource: AnyObject {
    var showActivityIndicatorView: VoidClosure? { get set }
    var hideActivityIndicatorView: VoidClosure? { get set }
    
    var showLoading: VoidClosure? { get set }
    var hideLoading: VoidClosure? { get set }
    
    var showWarningToast: StringClosure? { get set }
    var showSuccessToast: StringClosure? { get set }
    
    var showRetryButton: VoidClosure? { get set }
    var hideRetryButton: VoidClosure? { get set }
}

protocol BaseViewModelProtocol: BaseViewModelDataSource, BaseViewModelEventSource {
    func retryButtonTapped()
}

class BaseViewModel<R: Router>: BaseViewModelProtocol {
    
    let router: R
    let dataProvider: DataProviderProtocol
    
    var showActivityIndicatorView: VoidClosure?
    var hideActivityIndicatorView: VoidClosure?
    var showLoading: VoidClosure?
    var hideLoading: VoidClosure?
    var showWarningToast: StringClosure?
    var showSuccessToast: StringClosure?
    var showRetryButton: VoidClosure?
    var hideRetryButton: VoidClosure?
    
    func retryButtonTapped() { }
    
    init(router: R, dataProvider: DataProviderProtocol = apiDataProvider) {
        self.router = router
        self.dataProvider = dataProvider
    }
    
    #if DEBUG
    deinit {
        debugPrint("deinit \(self)")
    }
    #endif
}
