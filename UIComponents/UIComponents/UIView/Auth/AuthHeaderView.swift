//
//  AuthHeaderView.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

public class AuthHeaderView: UIView {
    
    private let titleLabel = UILabelBuilder()
        .textColor(.appCinder)
        .font(.font(.nunitoBold, size: .xxLarge))
        .textAlignment(.center)
        .numberOfLines(0)
        .build()
    
    public var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
    }
}

// MARK: - UILayout
extension AuthHeaderView {
    
    private func addSubviews() {
        addSubview(titleLabel)
        titleLabel.edgesToSuperview()
    }
}
