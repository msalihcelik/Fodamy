//
//  CustomRedButton.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 10.03.2022.
//

public class CustomRedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    // swiftlint:disable all
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable all
    
    public override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    public func setHeight(_ height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

// MARK: - Configure
extension CustomRedButton {
    
    private func configureContents() {
        backgroundColor = .appRed
        tintColor = .appWhite
        titleLabel?.font = .font(.nunitoBold, size: .xLarge)
        layer.cornerRadius = 5
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
