//
//  CategoryImage.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 21.03.2022.
//

public struct CategoryImage: Decodable {
    public let url: String?
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}
