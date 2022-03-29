//
//  RetryButton.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 29.03.2022.
//

public class RetryButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
}

// MARK: - Configure
extension RetryButton {
    
    private func configureContents() {
        backgroundColor = .appRed
        tintColor = .appWhite
        titleLabel?.font = .font(.nunitoBold, size: .xLarge)
        layer.cornerRadius = 5
        titleLabel?.textAlignment = .center
        setTitle(L10n.General.retry, for: .normal)
        size(.init(width: 150, height: 50))
    }
}
