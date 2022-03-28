//
//  GetCommentRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 26.03.2022.
//

public struct GetCommentRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = BaseResponse<[GetCommentResponse]>
    
    public var path: String = ""
    public let method: RequestMethod = .get
    public let parameters: RequestParameters = [:]
    public let headers: RequestHeaders = [:]
    
    public init(recipeId: Int) {
        self.path = "recipe/\(recipeId)/comment"
    }
}
