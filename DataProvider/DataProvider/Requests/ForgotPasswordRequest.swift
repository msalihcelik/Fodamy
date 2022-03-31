//
//  ForgotPasswordRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

public struct ForgotPasswordRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = Auth

    public let path: String = "auth/forgot"
    public let method: RequestMethod = .post
    public var parameters: RequestParameters = [:]
    
    public init(email: String) {
        parameters["email"] = email
    }
}
