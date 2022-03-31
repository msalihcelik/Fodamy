//
//  AuthBottomView.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

public class AuthBottomView: UIView {
    
    private let leftLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .textColor(.appRaven)
        .textAlignment(.center)
        .build()
    private let signButton = UIButtonBuilder()
        .titleFont(.font(.nunitoBold, size: .xLarge))
        .titleColor(.appRed)
        .build()
    private let stackView = UIStackViewBuilder()
        .axis(.horizontal)
        .alignment(.center)
        .build()
    
    public var leftLabelText: String? {
        didSet {
            leftLabel.text = leftLabelText
        }
    }
    
    public var signButtonTitle: String? {
        didSet {
            signButton.setTitle(signButtonTitle, for: .normal)
        }
    }
    
    public var actionClosure: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
        addSubviews()
    }
    
    // swiftlint:disable all
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable all
    
}

// MARK: - UILayout
extension AuthBottomView {
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(leftLabel)
        stackView.addArrangedSubview(signButton)
        stackView.centerXToSuperview()
        stackView.leadingToSuperview(relation: .equalOrGreater)
        stackView.trailingToSuperview(relation: .equalOrLess)
        stackView.setCustomSpacing(5, after: leftLabel)
        height(15)
    }
}

// MARK: - Configure
extension AuthBottomView {
    
    private func configureContents() {
        signButton.addTarget(self, action: #selector(signButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension AuthBottomView {
    
    @objc
    private func signButtonTapped() {
        actionClosure?()
    }
}

