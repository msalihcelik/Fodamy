//
//  FollowButton.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 24.03.2022.
//

public class FollowButton: UIButton {
    
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
extension FollowButton {
    
    private func configureContents() {
        height(40)
        layer.borderColor = UIColor.appRed.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 4
        titleLabel?.font = .font(.nunitoBold, size: .medium)
    }
}
