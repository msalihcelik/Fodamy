//
//  RegisterRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

public struct RegisterRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = Auth

    public let path: String = "auth/register"
    public let method: RequestMethod = .post
    public var parameters: RequestParameters = [:]
    
    public init(username: String, email: String, password: String) {
        parameters["username"] = username
        parameters["email"] = email
        parameters["password"] = password
    }
}
