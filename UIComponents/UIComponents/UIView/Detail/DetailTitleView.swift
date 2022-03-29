//
//  DetailTitleView.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 24.03.2022.
//

public class DetailTitleView: UIView {
    
    private let stackView = UIStackViewBuilder()
        .axis(.vertical)
        .build()
    
    private let recipeLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xLarge))
        .textColor(.appCinder)
        .build()
    
    private let categoryLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .xLarge))
        .textColor(.appRaven)
        .build()
    
    private let timeLabel = UILabelBuilder()
        .font(.font(.nunitoSemiBold, size: .medium))
        .textColor(.appRaven)
        .textAlignment(.right)
        .build()
    
    public var setRecipeText: String? {
        didSet {
            self.recipeLabel.text = setRecipeText
        }
    }
    
    public var setCategoryText: String? {
        didSet {
            self.categoryLabel.text = setCategoryText
        }
    }
    
    public var setTimeText: String? {
        didSet {
            self.timeLabel.text = setTimeText
        }
    }
    
    override init(frame: CGRect) {
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
extension DetailTitleView {
    
    private func addSubViews() {
        addStackView()
        addTimeLabel()
    }
    
    private func addStackView() {
        addSubview(stackView)
        stackView.centerYToSuperview()
        stackView.leftToSuperview(offset: 15)
        
        stackView.addArrangedSubview(recipeLabel)
        stackView.addArrangedSubview(categoryLabel)
    }
    
    private func addTimeLabel() {
        addSubview(timeLabel)
        timeLabel.centerY(to: stackView)
        timeLabel.rightToSuperview(offset: -15)
        timeLabel.leftToRight(of: stackView, offset: 5)
    }
}

// MARK: - Configure
extension DetailTitleView {
    
    private func configureContents() {
        backgroundColor = .appWhite
    }
}
