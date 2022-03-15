//
//  GetEditorChoiceRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 15.03.2022.
//

public struct GetEditorChoiceRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = BaseResponse<[Recipe]>
    
    public var path: String = "editor-choices"
    public var method: RequestMethod = .get
    public var parameters: RequestParameters = [:]
    public var headers: RequestHeaders = [:]

    public init(page: Int) {
        self.parameters["page"] = page
    }
}
