//
//  RecipeCategories.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 18.03.2022.
//

public struct RecipeCategories: Decodable {
    public let data: [RecipeCategoriesData]
    public let pagination: Pagination
    
    enum CodingKeys: String, CodingKey {
        case data
        case pagination
    }
}
