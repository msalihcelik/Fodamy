//
//  GetEditorChoiceRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 15.03.2022.
//

public struct GetEditorChoiceRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = BaseResponse<[Recipe]>
    
    public let path: String = "editor-choices"
    public let method: RequestMethod = .get
    public var parameters: RequestParameters = [:]
    public let headers: RequestHeaders = [:]

    public init(page: Int) {
        self.parameters["page"] = page
    }
}
