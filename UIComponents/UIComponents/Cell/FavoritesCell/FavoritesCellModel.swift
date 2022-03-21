//
//  FavoritesCellModel.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 16.03.2022.
//

public protocol FavoritesCellDataSource: AnyObject {
    var categoryId: Int { get }
    var headerLeftImageURL: String? { get }
    var headerCategoryName: String? { get }
    var cellItems: [FavoritesRecipeCellProtocol] { get set }
}

public protocol FavoritesCellEventSource: AnyObject {
    var reloadData: VoidClosure? { get set }
}

public protocol FavoritesCellProtocol: FavoritesCellDataSource, FavoritesCellEventSource {
    func testCount() -> Int
}

public final class FavoritesCellModel: FavoritesCellProtocol {
    
    public var categoryId: Int
    public var headerLeftImageURL: String?
    public var headerCategoryName: String?
    public var reloadData: VoidClosure?
    
    public var cellItems: [FavoritesRecipeCellProtocol] {
        didSet {
            self.reloadData?()
        }
    }
    
    public func testCount() -> Int {
        return self.cellItems.count
    }
    
    public init(categoryId: Int, imageURL: String?, categoryName: String?, cellItems: [FavoritesRecipeCellProtocol]) {
        self.categoryId = categoryId
        self.headerLeftImageURL = imageURL
        self.headerCategoryName = categoryName
        self.cellItems = cellItems
    }
    
    public convenience init(data: RecipeCategoriesData) {
        let cellItems = data.recipes.map({ FavoritesRecipeCellModel(recipe: $0) })
        guard let url = data.categoryImage?.url else {
            self.init(categoryId: data.id, imageURL: nil, categoryName: data.name, cellItems: cellItems)
            return
        }
        self.init(categoryId: data.id, imageURL: url, categoryName: data.name, cellItems: cellItems)
    }
}
