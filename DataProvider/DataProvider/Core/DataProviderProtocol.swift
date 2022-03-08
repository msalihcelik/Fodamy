//
//  DataProviderProtocol.swift
//  DataProvider
//
//  Created by Mehmet Salih ÇELİK on 8.03.2022.
//

public typealias DataProviderResult<T: Decodable> = ((Result<T, Error>) -> Void)

public protocol DataProviderProtocol {
    
    func request<T: DecodableResponseRequest>(for request: T,
                                              result: DataProviderResult<T.ResponseType>?)
}
