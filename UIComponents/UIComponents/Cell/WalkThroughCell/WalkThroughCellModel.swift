//
//  WalkThroughCellModel.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 9.03.2022.
//

import Foundation

public protocol WalkThroughCellDataSource: AnyObject {
    
}

public protocol WalkThroughCellEventSource: AnyObject {
    
}

public protocol WalkThroughCellProtocol: WalkThroughCellDataSource, WalkThroughCellEventSource {
    
}

public final class WalkThroughCellModel: WalkThroughCellProtocol {
    
}
