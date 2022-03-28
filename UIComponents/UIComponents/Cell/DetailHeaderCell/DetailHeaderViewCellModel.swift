//
//  DetailHeaderViewCellModel.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 24.03.2022.
//

public protocol DetailHeaderViewCellDataSource: AnyObject {
    var imageUrl: String { get }
    var isEditorChoice: Bool { get }
}

public protocol DetailHeaderViewCellEventSource: AnyObject {
    
}

public protocol DetailHeaderViewCellProtocol: DetailHeaderViewCellDataSource, DetailHeaderViewCellEventSource {
    
}

public final class DetailHeaderViewCellModel: DetailHeaderViewCellProtocol {
    
    public var imageUrl: String
    public var isEditorChoice: Bool
    
    public init(imageUrl: String, isEditorChoice: Bool) {
        self.imageUrl = imageUrl
        self.isEditorChoice = isEditorChoice
    }
}
