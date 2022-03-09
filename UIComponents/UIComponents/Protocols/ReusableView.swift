//
//  ReusableView.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 9.03.2022.
//

public protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
