//
//  Pagination.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 14.03.2022.
//

public struct Pagination: Decodable {
    public let currentPage: Int
    public let lastPage: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case lastPage = "last_page"
    }
}
