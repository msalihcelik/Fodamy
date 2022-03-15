//
//  ActivityIndicatorView.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 14.03.2022.
//

public class ActivityIndicatorView: UIActivityIndicatorView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        style = .gray
        tintColor = .appCinder
        hidesWhenStopped = true
    }
}
