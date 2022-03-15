//
//  GetLastAddedRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 15.03.2022.
//

public struct GetLastAddedRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = BaseResponse<[Recipe]>
    
    public var path: String = "recipe/"
    public let method: RequestMethod = .get
    public var parameters: RequestParameters = [:]
    public let headers: RequestHeaders = [:]
    
    public init(page: Int) {
        self.parameters["page"] = page
    }
}
