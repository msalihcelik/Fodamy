//
//  CountInfoView.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 24.03.2022.
//

public class CountInfoView: UIView {
    
    public var iconTappedAction: VoidClosure?
    
    private let icon = UIButtonBuilder()
        .tintColor(.appCinder)
        .build()
    private let stackView = UIStackViewBuilder()
        .axis(.horizontal)
        .build()
    private let countLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .textColor(.appRed)
        .textAlignment(.center)
        .build()
    private let infoLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .textColor(.appRaven)
        .textAlignment(.center)
        .build()
    
    public var setInfo: String? {
        didSet {
            infoLabel.text = setInfo
        }
    }
    
    public var setCount: Int? {
        didSet {
            countLabel.text = setCount?.toString
        }
    }
    
    public var setIcon: UIImage? {
        didSet {
            icon.setImage(setIcon, for: .normal)
        }
    }
    
    public var setIconColor: UIColor? {
        didSet {
            icon.tintColor = setIconColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    private func configureContents() {
        backgroundColor = .appWhite
        
        addSubview(icon)
        icon.topToSuperview(offset: 15)
        icon.centerXToSuperview()
        icon.size(CGSize(width: 20, height: 18))
        icon.addTarget(self, action: #selector(iconTapped), for: .touchUpInside)
        
        addSubview(stackView)
        stackView.topToBottom(of: icon).constant = 7
        stackView.bottomToSuperview(offset: -10)
        stackView.centerXToSuperview()
        stackView.addArrangedSubview(countLabel)
        stackView.addArrangedSubview(infoLabel)
    }
}

// MARK: - Action
extension CountInfoView {
    
    @objc
    private func iconTapped() {
        iconTappedAction?()
    }
}
