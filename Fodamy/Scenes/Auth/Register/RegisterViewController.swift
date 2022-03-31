//
//  RegisterViewController.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

final class RegisterViewController: BaseViewController<RegisterViewModel> {
    
    private let scrollView = UIScrollViewBuilder()
        .build()
    private let contentView = UIViewBuilder()
        .build()
    private let headerView = AuthHeaderView()
    
    private let contentStackView = UIStackViewBuilder()
        .spacing(15)
        .axis(.vertical)
        .build()
    
    private let formStackView = UIStackViewBuilder()
        .axis(.vertical)
        .distribution(.fillEqually)
        .spacing(15)
        .build()
    private let usernameTextField = FloatingLabelTextField()
    private let emailTextField = FloatingLabelTextField()
    private let passwordTextField = FloatingLabelTextField()
    
    private let buttonStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(10)
        .build()
    private let forgotPasswordContainerView = UIViewBuilder()
        .build()
    private let forgotPasswordButton = UIButtonBuilder()
        .titleFont(.font(.nunitoSemiBold, size: .xLarge))
        .titleColor(.appRaven)
        .build()
    private let signUpButton = AppButton()

    private let signInView = AuthBottomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
        setLocalize()
    }
}

// MARK: - UILayout
extension RegisterViewController {
    
    private func addSubviews() {
        addScrollView()
        addContentView()
        addHeader()
        addContentStackView()
        addFormStackView()
        addButtonStackView()
        addSignInView()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
    }
    
    private func addContentView() {
        scrollView.addSubview(contentView)
        contentView.edgesToSuperview()
        contentView.widthToSuperview()
    }
    
    private func addHeader() {
        contentView.addSubview(headerView)
        headerView.edgesToSuperview(excluding: .bottom, insets: .init(top: 50, left: 15, bottom: 0, right: 15))
    }
    
    private func addContentStackView() {
        contentView.addSubview(contentStackView)
        contentStackView.topToBottom(of: headerView, offset: 50)
        contentStackView.edgesToSuperview(excluding: .top, insets: .left(15) + .right(15))
        
        contentStackView.addArrangedSubview(formStackView)
        contentStackView.addArrangedSubview(buttonStackView)
    }
    
    private func addFormStackView() {
        formStackView.addArrangedSubview(usernameTextField)
        formStackView.addArrangedSubview(emailTextField)
        formStackView.addArrangedSubview(passwordTextField)
    }
    
    private func addButtonStackView() {
        buttonStackView.addArrangedSubview(signUpButton)
        buttonStackView.addArrangedSubview(forgotPasswordContainerView)
        
        forgotPasswordContainerView.addSubview(forgotPasswordButton)
        forgotPasswordButton.edgesToSuperview(excluding: .left)
    }
    
    private func addSignInView() {
        view.addSubview(signInView)
        signInView.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 15, bottom: 21, right: 15), usingSafeArea: true)
        signInView.topToBottom(of: scrollView)
    }
}

// MARK: - Configure & SetLocalize
extension RegisterViewController {
    
    private func configureContents() {
        configureSignUpView()
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        usernameTextField.leftImage = .icUser
        emailTextField.leftImage = .icMail
        passwordTextField.leftImage = .icPassword
        passwordTextField.isSecureTextEntry = true
    }
    
    private func configureSignUpView() {
        signInView.actionClosure = { [weak self] in
            self?.viewModel.pushSignIn()
        }
    }
    
    private func setLocalize() {
        headerView.titleText = L10n.Register.title
        
        usernameTextField.placeholderText = L10n.Register.username
        emailTextField.placeholderText = L10n.Register.email
        passwordTextField.placeholderText = L10n.Register.password
        
        forgotPasswordButton.setTitle(L10n.Register.forgotPassword, for: .normal)
        signUpButton.setTitle(L10n.Register.title, for: .normal)
        
        signInView.leftLabelText = L10n.Register.haveAccount
        signInView.signButtonTitle = L10n.Register.signIn
    }
}

// MARK: - Actions
extension RegisterViewController {
    
    @objc
    private func forgotPasswordButtonTapped() {
        viewModel.pushPasswordResetScene()
    }
    
    @objc
    private func signUpButtonTapped() {
        
        guard let username = usernameTextField.text, !username.isEmpty else {
            viewModel.showWarningToast?(L10n.Register.emptyUsername)
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            viewModel.showWarningToast?(L10n.Register.emptyEmail)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            viewModel.showWarningToast?(L10n.Register.emptyPassword)
            return
        }
        
        let validation = Validation()
        guard validation.isValidName(username) else { return }
        guard validation.isValidPassword(password) else { return }
        guard validation.isValidEmail(email) else { return }
        viewModel.signUpButtonTapped(username: username, email: email, password: password)
    }
}
