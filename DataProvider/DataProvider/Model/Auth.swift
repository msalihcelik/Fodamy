//
//  Auth.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 31.03.2022.
//

public struct Auth: Decodable {
    public let token: String
    public let user: User
}
