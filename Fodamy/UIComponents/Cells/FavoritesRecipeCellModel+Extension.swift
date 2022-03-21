//
//  FavoritesRecipeCellModel+Extension.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 21.03.2022.
//

extension FavoritesRecipeCellModel {
    
    public convenience init(recipe: Recipe) {
        self.init(profileImageURL: recipe.user.image?.url,
                  username: recipe.user.username,
                  recipeImageURL: recipe.images.first?.url,
                  recipeTitle: recipe.title,
                  recipeInfo: "\(recipe.commentCount) Yorum \(recipe.likeCount) Beğeni",
                  isEditorChoice: recipe.isEditorChoice)
    }
}
