//
//  FavoritesCellModel+Extension.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 21.03.2022.
//

extension FavoritesCellModel {
    
    public convenience init(data: RecipeCategoriesData) {
        let cellItems = data.recipes.map({ FavoritesRecipeCellModel(recipe: $0) })
        guard let url = data.categoryImage?.url else {
            self.init(categoryId: data.id, imageURL: nil, categoryName: data.name, cellItems: cellItems)
            return
        }
        self.init(categoryId: data.id, imageURL: url, categoryName: data.name, cellItems: cellItems)
    }
}
