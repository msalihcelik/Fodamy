//
//  BaseResponse.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 14.03.2022.
//

public struct BaseResponse<T: Decodable>: Decodable {
    public let data: T
    public let pagination: Pagination
}
