//
//  FavoritesCellModel+Extension.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 21.03.2022.
//

extension FavoritesCellModel {
    
    public convenience init(data: RecipeCategoriesData) {
        let cellItems = data.recipes.map({ FavoritesRecipeCellModel(recipe: $0) })
        self.init(categoryId: data.id, imageURL: data.categoryImage?.url, categoryName: data.name, cellItems: cellItems)
    }
}
