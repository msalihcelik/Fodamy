//
//  DynamicHeightCollectionView.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 28.03.2022.
//

public class DynamicHeightCollectionView: UICollectionView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        return contentSize
    }
}
