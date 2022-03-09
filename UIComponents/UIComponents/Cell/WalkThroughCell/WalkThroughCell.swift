//
//  WalkThroughCell.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 9.03.2022.
//

import UIKit

public class WalkThroughCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: WalkThroughCellProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
    }
    
    private func configureContents() {
        
    }
    
    public func set(viewModel: WalkThroughCellProtocol) {
        self.viewModel = viewModel
        
    }
    
}
