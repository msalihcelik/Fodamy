//
//  ActivityIndicatorFooterView.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 14.03.2022.
//

public class ActivityIndicatorFooterView: UICollectionReusableView, ReusableView {
    
    public let activityIndicator = ActivityIndicatorView(frame: .infinite)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }

    private func setupConstraints() {
        addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
    }
}
