//
//  DetailInfoView.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 24.03.2022.
//

public class DetailInfoView: UIView {
    
    private let headerView = UIViewBuilder()
        .build()
    private let titleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xLarge))
        .textColor(.appCinder)
        .build()
    private let stackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(2)
        .alignment(.center)
        .build()
    private let imageView = UIImageViewBuilder()
        .clipsToBounds(true)
        .size(CGSize(width: 34, height: 34))
        .cornerRadius(17)
        .borderWidth(2)
        .borderColor(UIColor.appZircon.cgColor)
        .tintColor(.appCinder)
        .contentMode(.center)
        .build()
    private let imageLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .small))
        .textColor(.appRaven)
        .build()
    
    private let separator = UIViewBuilder()
        .backgroundColor(.appZircon)
        .build()
    
    private let infoLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .textColor(.appCinder)
        .numberOfLines(0)
        .build()
    
    public var setTitleText: String? {
        didSet {
            titleLabel.text = setTitleText
        }
    }
    
    public var setInfoText: String? {
        didSet {
            infoLabel.text = setInfoText
        }
    }
    
    public var setImage: UIImage? {
        didSet {
            imageView.image = setImage
        }
    }
    
    public var setImageSubtitle: String? {
        didSet {
            imageLabel.text = setImageSubtitle
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubViews()
        configureContents()
    }
}

// MARK: - UILayout
extension DetailInfoView {
    
    private func addSubViews() {
        addHeaderView()
        addTitleLabel()
        addStackView()
        addSeparator()
        addInfoLabel()
    }
    
    private func addHeaderView() {
        addSubview(headerView)
        headerView.edgesToSuperview(excluding: .bottom)
    }
    
    private func addTitleLabel() {
        headerView.addSubview(titleLabel)
        titleLabel.centerYToSuperview()
        titleLabel.leftToSuperview(offset: 15)
    }
    
    private func addStackView() {
        headerView.addSubview(stackView)
        stackView.centerYToSuperview()
        stackView.rightToSuperview(offset: -15)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(imageLabel)
    }
    
    private func addSeparator() {
        addSubview(separator)
        separator.edgesToSuperview(excluding: [.top, .bottom])
        separator.topToBottom(of: headerView)
    }
    
    private func addInfoLabel() {
        addSubview(infoLabel)
        infoLabel.edgesToSuperview(excluding: .top, insets: .init(top: 0, left: 15, bottom: 10, right: 15))
        infoLabel.topToBottom(of: separator, offset: 11)
    }
}

// MARK: - Configure & SetLocalize
extension DetailInfoView {
    
    private func configureContents() {
        headerView.height(78.5)
        separator.height(1)
        backgroundColor = .appWhite
    }
}
