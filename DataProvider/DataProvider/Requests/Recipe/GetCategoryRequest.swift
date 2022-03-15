//
//  GetCategoryRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 15.03.2022.
//

public struct GetCategoryRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = BaseResponse<[Recipe]>
    
    public var path: String = ""
    public let method: RequestMethod = .get
    public var parameters: RequestParameters = [:]
    public let headers: RequestHeaders = [:]
    
    public init(page: Int, categoryId: Int) {
        self.path = "category/\(categoryId)/recipe"
        self.parameters["page"] = page
    }
}
