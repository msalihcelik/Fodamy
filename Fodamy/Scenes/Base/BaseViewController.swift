//
//  BaseViewController.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 7.03.2022.
//

class BaseViewController<V: BaseViewModelProtocol>: UIViewController {
    
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
        view.backgroundColor = .white
    }
    
    #if DEBUG
    deinit {
        debugPrint("deinit \(self)")
    }
    #endif
    
}
