//
//  CommentCellModel.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 25.03.2022.
//

public protocol CommentCellDataSource: AnyObject {
    var userId: Int { get }
    var imageUrl: String? { get }
    var username: String? { get }
    var recipeAndFollower: String? { get }
    var time: String? { get }
    var commentId: Int { get }
    var commentText: String? { get set }
    var isOwner: Bool { get set }
}

public protocol CommentCellEventSource: AnyObject {
    var ownerButtonTapped: VoidClosure? { get set }
    var commentChanged: VoidClosure? { get set }
}

public protocol CommentCellProtocol: CommentCellDataSource, CommentCellEventSource {}

public final class CommentCellModel: CommentCellProtocol {
    
    public var ownerButtonTapped: VoidClosure?
    public var commentChanged: VoidClosure?
    
    public var isOwner: Bool
    
    public var userId: Int
    public var imageUrl: String?
    public var username: String?
    public var recipeAndFollower: String?
    public var time: String?
    public var commentId: Int
    public var commentText: String?

    public init(userId: Int,
                imageUrl: String?,
                username: String?,
                recipeAndFollower: String?,
                time: String?,
                commentId: Int,
                commentText: String?,
                isOwner: Bool) {
        self.userId = userId
        self.imageUrl = imageUrl
        self.username = username
        self.recipeAndFollower = recipeAndFollower
        self.time = time
        self.commentId = commentId
        self.commentText = commentText
        self.isOwner = isOwner
    }
}
