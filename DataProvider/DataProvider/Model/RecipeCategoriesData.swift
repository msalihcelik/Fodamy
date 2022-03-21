//
//  RecipeCategoriesData.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 18.03.2022.
//

public struct RecipeCategoriesData: Decodable {
    public let id: Int
    public let name: String
    public let recipes: [Recipe]
    public let categoryImage: CategoryImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case recipes
        case categoryImage = "image"
    }
}
