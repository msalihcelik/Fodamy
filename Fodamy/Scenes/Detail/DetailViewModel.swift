//
//  DetailViewModel.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 24.03.2022.
//

protocol DetailViewDataSource {
    var titleRecipeName: String? { get }
    var titleCategoryName: String? { get }
    var titleTimeText: String? { get }
    var commentCount: Int? { get }
    var likeCount: Int? { get }
    var isLiked: Bool { get }
    var userId: Int? { get }
    var username: String? { get }
    var userImageUrl: String? { get }
    var userRecipeCount: Int? { get }
    var userFollowedCount: Int? { get }
    var userRecipeAndFollower: String? { get }
    var isFollowing: Bool { get }
    var necessaries: String? { get }
    var numberOfPerson: String? { get }
    var stages: String? { get }
    var time: String? { get }
    
    func numberOfItemsAt(section: Int) -> Int
    func cellItemAt(indexPath: IndexPath) -> CommentCellProtocol
}

protocol DetailViewEventSource {
    var toggleIsLiked: VoidClosure? { get set }
    var toggleIsFollowing: VoidClosure? { get set }
    var reloadCommentData: VoidClosure? { get set }
    var reloadDetailData: VoidClosure? { get set }
}

protocol DetailViewProtocol: DetailViewDataSource, DetailViewEventSource {}

final class DetailViewModel: BaseViewModel<DetailRouter>, DetailViewProtocol {

    let recipeId: Int
    
    var titleRecipeName: String?
    var titleCategoryName: String?
    var titleTimeText: String?
    
    var commentCount: Int?
    var likeCount: Int?
    var isLiked = false
    
    var userId: Int?
    var username: String?
    var userImageUrl: String?
    
    var userRecipeCount: Int?
    var userRecipeAndFollower: String?
    var isFollowing = false
    var userFollowedCount: Int? {
        didSet {
            userRecipeAndFollower = "\(userRecipeCount ?? 0) \(L10n.Detail.recipe) \(userFollowedCount ?? 0) \(L10n.Detail.follower)"
        }
    }
    
    var necessaries: String?
    var numberOfPerson: String?
    
    var stages: String?
    var time: String?

    var toggleIsLiked: VoidClosure?
    var toggleIsFollowing: VoidClosure?
    
    var reloadCommentData: VoidClosure?
    var reloadDetailData: VoidClosure?
    
    var cellItems: [CommentCellProtocol] = []
    var headerCellItems: [DetailHeaderViewCellProtocol] = []
    
    let keychain = KeychainSwift()
    let group = DispatchGroup()
    
    var isRecipeDataFetched: Bool = false
    var isCommentsFetched: Bool = false
    
    var showSubViews: VoidClosure?
    
    init(recipeId: Int, router: DetailRouter) {
        self.recipeId = recipeId
        super.init(router: router)
    }
    
    func numberOfItemsAt(section: Int) -> Int {
        return cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> CommentCellProtocol {
        return cellItems[indexPath.row]
    }
    
    private func setDetail(recipeDetail: GetDetailResponse) {
        titleRecipeName = recipeDetail.title
        titleCategoryName = recipeDetail.category.name
        titleTimeText = recipeDetail.timeDifference
        
        userId = recipeDetail.user.id
        username = recipeDetail.user.username
        userImageUrl = recipeDetail.user.image?.url
        userRecipeCount = recipeDetail.user.recipeCount
        userFollowedCount = recipeDetail.user.followedCount
        
        commentCount = recipeDetail.commentCount
        likeCount = recipeDetail.likeCount
        
        necessaries = recipeDetail.ingredients
        numberOfPerson = recipeDetail.numberOfPerson.text
        
        stages = recipeDetail.instructions
        time = recipeDetail.timeOfRecipe.text
        
        isLiked = recipeDetail.isLiked
        isFollowing = recipeDetail.user.isFollowing
 
        for image in recipeDetail.images {
            headerCellItems.append(DetailHeaderViewCellModel(imageUrl: image.url ?? "", isEditorChoice: recipeDetail.isEditorChoice))
        }
    }
    
    override func retryButtonTapped() {
        hideRetryButton?()
        getData()
    }
}

// MARK: - Actions
extension DetailViewModel {
    
    func commentButtonTapped() {
//        router.pushCommentList(recipeId: recipeId, isKeyboardOpen: true)
    }
}

// MARK: - Network
extension DetailViewModel {
    
    func getData() {
        
        if !isCommentsFetched || !isRecipeDataFetched {
            self.showActivityIndicatorView?()
        }
        
        if !isRecipeDataFetched {
            getRecipeDetail()
        }
        
        if !isCommentsFetched {
            getRecipeComment()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            if self.isRecipeDataFetched && self.isCommentsFetched {
                self.reloadDetailData?()
                self.reloadCommentData?()
                self.showSubViews?()
            } else {
                self.showRetryButton?()
            }
        }
    }
    
    func getRecipeDetail() {
        group.enter()
        dataProvider.request(for: GetDetailRequest(recipeId: recipeId)) { [weak self] result in
            guard let self = self else { return }
            self.group.leave()
            switch result {
            case .success(let recipeDetail):
                self.setDetail(recipeDetail: recipeDetail)
                self.isRecipeDataFetched = true
            case .failure(let error ):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
    
    func getRecipeComment() {
        
        let request = GetCommentRequest(recipeId: recipeId)
        group.enter()
        dataProvider.request(for: request) { [weak self] result in
            guard let self = self else { return }
            self.group.leave()
            switch result {
            case .success(let response):
                let cellItems = response.data.map({ CommentCellModel(comment: $0) })
                self.cellItems = cellItems
                self.isCommentsFetched = true
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
    
    func likeButtonTapped() {
        guard keychain.get(Keychain.token) != nil else {
            router.presentLoginPopUpGenerator(loginHandler: { [weak self] in
                
            })
            return
        }
    }
}
