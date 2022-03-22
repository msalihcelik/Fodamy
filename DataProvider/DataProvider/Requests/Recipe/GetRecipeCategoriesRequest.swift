//
//  GetRecipeCategoriesRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 18.03.2022.
//

public struct GetRecipeCategoriesRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = RecipeCategories

    public let path: String = "category-recipes"
    public let method: RequestMethod = .get
    public var parameters: RequestParameters = [:]
    
    public init(page: Int) {
        parameters["page"] = page
    }
}
