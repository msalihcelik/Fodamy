//
//  CommentCellModel+Extension.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 28.03.2022.
//

extension CommentCellModel {
    
    public convenience init(comment: GetCommentResponse) {
        let recipeAndFollower = L10n.Comment.recipeAndFollower(comment.user.recipeCount, comment.user.followedCount)
        let isOwner = comment.user.id == DefaultsKey.userId.value
        self.init(userId: comment.user.id,
                  imageUrl: comment.user.image?.url,
                  username: comment.user.username,
                  recipeAndFollower: recipeAndFollower,
                  time: comment.difference,
                  commentId: comment.id,
                  commentText: comment.text,
                  isOwner: isOwner)
    }
}
