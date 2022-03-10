//
//  appTitleView.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 10.03.2022.
//

public class AppTitleView: UIView {
    
    private var imageView = UIImageView()
    private var insets = UIEdgeInsets()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(image: UIImage, insets: UIEdgeInsets) {
        self.init(frame: .zero)
        self.imageView.image = image
        self.insets = insets
        addSubViews()
    }
    
    // swiftlint:disable all
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable all
}

// MARK: - UILayout
extension AppTitleView {
    
    private func addSubViews() {
        addSubview(imageView)
        imageView.edgesToSuperview(insets: self.insets)
    }
}
