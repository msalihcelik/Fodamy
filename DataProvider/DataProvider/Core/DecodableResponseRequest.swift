//
//  DecodableResponseRequest.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 8.03.2022.
//

public protocol DecodableResponseRequest: RequestProtocol {
    associatedtype ResponseType: Decodable
}
