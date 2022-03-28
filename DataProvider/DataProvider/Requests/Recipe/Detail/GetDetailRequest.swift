//
//  GetDetailRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 25.03.2022.
//

public struct GetDetailRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = GetDetailResponse
    
    public var path: String = "recipe/{recipeId}"
    public let method: RequestMethod = .get
    public let parameters: RequestParameters = [:]
    public let headers: RequestHeaders = [:]
    
    public init(recipeId: Int) {
        self.path = "recipe/\(recipeId)"
    }
}
