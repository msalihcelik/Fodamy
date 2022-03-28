//
//  GetCommentResponse.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 26.03.2022.
//

public struct GetCommentResponse: Decodable {
    public let id: Int
    public let text: String?
    public let difference: String?
    public let user: User
}
