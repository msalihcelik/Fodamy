//
//  EmptyCellModel.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 26.03.2022.
//

public protocol EmptyCellDataSource: AnyObject {
    
}

public protocol EmptyCellEventSource: AnyObject {
    
}

public protocol EmptyCellProtocol: EmptyCellDataSource, EmptyCellEventSource {
    
}

public final class EmptyCellModel: EmptyCellProtocol {
    
}
