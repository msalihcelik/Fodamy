//
//  LoginRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

public struct LoginRequest: ApiDecodableResponseRequest {
    
    public typealias ResponseType = Auth

    public let path: String = "auth/login"
    public let method: RequestMethod = .post
    public var parameters: RequestParameters = [:]
    
    public init(username: String, password: String) {
        parameters["username"] = username
        parameters["password"] = password
    }
}
