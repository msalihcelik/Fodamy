//
//  GetRecipesRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 14.03.2022.
//

public struct GetRecipesRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = BaseResponse<[Recipe]>
    
    public var path: String = ""
    public var method: RequestMethod = .get
    public var parameters: RequestParameters = [:]
    public let listType: ListType
    
    public init(page: Int, listType: ListType) {
        self.parameters["page"] = page
        self.listType = listType
        switch listType {
        case .editorChoiceRecipes:
            path = "editor-choices"
        case .lastAddedRecipes:
            path = "recipe/"
        case .categoryRecipes(let categoryId):
            path = "category/\(categoryId)/recipe"
        }
    }
}

public enum ListType {
    case editorChoiceRecipes
    case lastAddedRecipes
    case categoryRecipes(categoryId: Int)
}
