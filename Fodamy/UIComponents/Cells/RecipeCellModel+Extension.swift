//
//  RecipeCellModel+Extension.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 14.03.2022.
//

extension RecipeCellModel {
    
    convenience init(recipe: Recipe) {
        self.init(recipeId: recipe.id,
                  userId: recipe.user.id,
                  userImageUrl: recipe.user.image?.url,
                  username: recipe.user.username,
                  userRecipeAndFollowerCountText: "\(recipe.user.recipeCount) \(L10n.Comment.recipe) \(recipe.user.followingCount) \(L10n.Comment.follower)",
                  recipeTitle: recipe.title,
                  categoryName: recipe.category.name,
                  recipeImageUrl: recipe.images.first?.url,
                  recipeCommnetAndLikeCountText: "\(recipe.commentCount) \(L10n.Detail.comment) \(recipe.likeCount) \(L10n.Detail.like)",
                  isEditorChoice: recipe.isEditorChoice)
    }
}
