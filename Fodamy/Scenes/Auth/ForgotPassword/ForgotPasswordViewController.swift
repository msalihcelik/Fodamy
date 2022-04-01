//
//  ForgotPasswordViewController.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

final class ForgotPasswordViewController: BaseViewController<ForgotPasswordViewModel> {
    
    private let scrollView = UIScrollViewBuilder()
        .build()
    private let contentView = UIViewBuilder()
        .build()
    private let stackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    private let headerView = AuthHeaderView()
    private let emailTextField = FloatingLabelTextField()
    private let resetButton = AppButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        setLocalize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.backButtonTitle = L10n.General.back
    }
}

// MARK: - UILayout
extension ForgotPasswordViewController {
    
    private func addSubViews() {
        addScrollView()
        addContentView()
        addStackView()
        addHeaderView()
        addEmailTextField()
        addResetButton()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.edgesToSuperview(usingSafeArea: true)
    }
    
    private func addContentView() {
        scrollView.addSubview(contentView)
        contentView.edgesToSuperview()
        contentView.widthToSuperview()
    }
    
    private func addStackView() {
        contentView.addSubview(stackView)
        stackView.edgesToSuperview(insets: .init(top: 50, left: 15, bottom: 0, right: 15))
    }
    
    private func addHeaderView() {
        stackView.addArrangedSubview(headerView)
        stackView.setCustomSpacing(50, after: headerView)
    }
    
    private func addEmailTextField() {
        stackView.addArrangedSubview(emailTextField)
        stackView.setCustomSpacing(15, after: emailTextField)
    }
    
    private func addResetButton() {
        stackView.addArrangedSubview(resetButton)
    }
}

// MARK: - Configure & SetLocalize
extension ForgotPasswordViewController {
    
    private func configureContents() {
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        emailTextField.leftImage = .icMail
    }
    
    private func setLocalize() {
        headerView.titleText = L10n.Forgot.title
        emailTextField.placeholderText = L10n.Forgot.email
        resetButton.setTitle(L10n.Forgot.reset, for: .normal)
    }
}

// MARK: - Actions
extension ForgotPasswordViewController {
    
    @objc
    private func resetButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            viewModel.showWarningToast?(L10n.Forgot.emptyEmail)
            return
        }
        
        let validation = Validation()
        guard validation.isValidEmail(email) else { return }
        viewModel.resetButtonTapped(email: email)
    }
}
