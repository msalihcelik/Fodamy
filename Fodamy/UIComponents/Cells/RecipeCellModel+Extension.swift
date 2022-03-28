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
                  userRecipeAndFollowerCountText: "\(L10n.Recipe.recipeAndFollower(recipe.user.recipeCount, recipe.user.followingCount))",
                  recipeTitle: recipe.title,
                  categoryName: recipe.category.name,
                  recipeImageUrl: recipe.images.first?.url,
                  recipeCommnetAndLikeCountText: "\(L10n.Recipe.recipeCommnetAndLike(recipe.commentCount, recipe.likeCount))",
                  isEditorChoice: recipe.isEditorChoice)
    }
}
