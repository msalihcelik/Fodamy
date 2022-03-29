//
//  FavoritesRecipeCellModel.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 17.03.2022.
//

public protocol FavoritesRecipeCellDataSource: AnyObject {
    var profileImageURL: String? { get }
    var username: String? { get }
    var recipeImageURL: String? { get }
    var recipeTitle: String? { get }
    var recipeInfo: String? { get }
    var isEditorChoice: Bool? { get }
    var recipeId: Int? { get }
}

public protocol FavoritesRecipeCellEventSource: AnyObject { }

public protocol FavoritesRecipeCellProtocol: FavoritesRecipeCellDataSource, FavoritesRecipeCellEventSource {
    
}

public final class FavoritesRecipeCellModel: FavoritesRecipeCellProtocol {
    
    public var profileImageURL: String?
    public var username: String?
    public var recipeImageURL: String?
    public var recipeTitle: String?
    public var recipeInfo: String?
    public var isEditorChoice: Bool?
    public var recipeId: Int?
    
    public init(profileImageURL: String?,
                username: String?,
                recipeImageURL: String?,
                recipeTitle: String?,
                recipeInfo: String?,
                isEditorChoice: Bool?,
                recipeId: Int?) {
        self.profileImageURL = profileImageURL
        self.username = username
        self.recipeImageURL = recipeImageURL
        self.recipeTitle = recipeTitle
        self.recipeInfo = recipeInfo
        self.isEditorChoice = isEditorChoice
        self.recipeId = recipeId
    }
}
