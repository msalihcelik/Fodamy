//
//  LoginViewController.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

final class LoginViewController: BaseViewController<LoginViewModel> {
    
    private let scrollView = UIScrollViewBuilder()
        .build()
    
    private let contentView = UIViewBuilder()
        .build()
    
    private let headerView = AuthHeaderView()
    
    private let contentStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(15)
        .build()

    private let formStackView = UIStackViewBuilder()
        .axis(.vertical)
        .distribution(.fillEqually)
        .spacing(15)
        .build()
    
    private let emailTextField = FloatingLabelTextField()
    private let passwordTextField = FloatingLabelTextField()

    private let buttonStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(10)
        .build()
    private let forgotPasswordContainerView = UIViewBuilder()
        .build()
    private let forgotPasswordButton = UIButtonBuilder()
        .titleFont(.font(.nunitoSemiBold, size: .large))
        .titleColor(.appRaven)
        .build()
    private let signInButton = AppButton()

    private let signUpView = AuthBottomView()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
        setLocalize()
    }
}

// MARK: - UILayout
extension LoginViewController {

    private func addSubviews() {
        addScrollView()
        addContentView()
        addheaderView()
        addContentStackView()
        addFormStackView()
        addButtonStackView()
        addSignUpView()
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

    private func addheaderView() {
        contentView.addSubview(headerView)
        headerView.edgesToSuperview(excluding: .bottom, insets: .init(top: 50, left: 15, bottom: 0, right: 15))
    }
    
    private func addContentStackView() {
        contentView.addSubview(contentStackView)
        contentStackView.topToBottom(of: headerView, offset: 50)
        contentStackView.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 15, bottom: 0, right: 15))
        
        contentStackView.addArrangedSubview(formStackView)
        contentStackView.addArrangedSubview(buttonStackView)
    }

    private func addFormStackView() {
        formStackView.addArrangedSubview(emailTextField)
        formStackView.addArrangedSubview(passwordTextField)
    }

    private func addButtonStackView() {
        buttonStackView.addArrangedSubview(signInButton)
        buttonStackView.addArrangedSubview(forgotPasswordContainerView)

        forgotPasswordContainerView.addSubview(forgotPasswordButton)
        forgotPasswordButton.edgesToSuperview(excluding: .left)
    }

    private func addSignUpView() {
        view.addSubview(signUpView)
        signUpView.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 15, bottom: 21, right: 15), usingSafeArea: true)
        signUpView.topToBottom(of: scrollView)
    }
}

// MARK: - Configure & SetLocalize
extension LoginViewController {
    
    private func configureContents() {
        configureSignUpView()
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)

        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        emailTextField.leftImage = .icMail
        passwordTextField.leftImage = .icPassword
        passwordTextField.isSecureTextEntry = true
    }

    private func configureSignUpView() {
        signUpView.actionClosure = { [weak self] in
            self?.viewModel.signUpButtonTapped()
        }
    }

    private func setLocalize() {
        headerView.titleText = L10n.Login.title

        emailTextField.placeholderText = L10n.Login.email
        passwordTextField.placeholderText = L10n.Login.password

        forgotPasswordButton.setTitle(L10n.Login.forgotPassword, for: .normal)
        signInButton.setTitle(L10n.Login.title, for: .normal)

        signUpView.leftLabelText = L10n.Login.haveNotAccount
        signUpView.signButtonTitle = L10n.Login.signUp
    }
}

// MARK: - Actions
extension LoginViewController {
    
    @objc
    private func forgotPasswordButtonTapped() {
        viewModel.pushPasswordResetScene()
    }

    @objc
    private func signInButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            viewModel.showWarningToast?(L10n.Login.emptyEmail)
            return
        }

        guard let password = passwordTextField.text, !password.isEmpty else {
            viewModel.showWarningToast?(L10n.Login.emptyPassword)
            return
        }

        let validation = Validation()
        guard validation.isValidPassword(password) else { return }
        guard validation.isValidEmail(email) else { return }
        viewModel.signInButtonTapped(email: email, password: password)
    }
}
