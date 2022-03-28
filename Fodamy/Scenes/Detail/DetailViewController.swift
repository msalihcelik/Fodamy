//
//  DetailViewController.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 24.03.2022.
//

final class DetailViewController: BaseViewController<DetailViewModel> {
    
    private let scrollView = UIScrollViewBuilder()
        .build()
    private let mainStackView = UIStackViewBuilder()
        .axis(.vertical)
        .spacing(15)
        .build()
    
    private let headerView = DetailHeaderView()
    private let titleView = DetailTitleView()
    
    private let countInfoStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .spacing(1)
        .distribution(.fillEqually)
        .build()
    private let commentCountView = CountInfoView()
    private let likeCountView = CountInfoView()
    
    private let userView = UserView(userViewType: .withFollowButton)
    private let necessariesView = DetailInfoView()
    private let stagesView = DetailInfoView()
    
    private let commentsView = UIViewBuilder()
        .backgroundColor(.appWhite)
        .build()
    private let commentsTitleLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .xLarge))
        .textColor(.appCinder)
        .text(L10n.Detail.comments)
        .build()
    private let separator = UIViewBuilder()
        .backgroundColor(.appZircon)
        .build()
    
    private let commentsCollectionView: DynamicHeightCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .appSecondaryBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CommentCell.self)
        collectionView.register(EmptyCell.self)
        return collectionView
    }()
    
    private let commentButtonView = UIViewBuilder()
        .backgroundColor(.clear)
        .build()
    
    private let commentButton = AppButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        setLocalize()
        subscribeViewModel()
        viewModel.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userView.isFollowButtonHidden = true
    }
}

// MARK: - UILayout
extension DetailViewController {
    
    private func addSubViews() {
        addScrollView()
        addMainStackView()
        addCountInfoStackView()
        addCommentsView()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.edgesToSuperview(usingSafeArea: true)
    }
    
    private func addMainStackView() {
        scrollView.addSubview(mainStackView)
        mainStackView.edgesToSuperview()
        mainStackView.widthToSuperview()
        
        mainStackView.addArrangedSubview(headerView)
        mainStackView.setCustomSpacing(0, after: headerView)
        headerView.height(375)
        headerView.aspectRatio(1)
        
        mainStackView.addArrangedSubview(titleView)
        mainStackView.setCustomSpacing(1, after: titleView)
        titleView.height(65)
        
        mainStackView.addArrangedSubview(countInfoStackView)
        mainStackView.addArrangedSubview(userView)
        mainStackView.addArrangedSubview(necessariesView)
        mainStackView.addArrangedSubview(stagesView)
        mainStackView.addArrangedSubview(commentsView)
        mainStackView.addArrangedSubview(commentButtonView)
    }
    
    private func addCountInfoStackView() {
        countInfoStackView.addArrangedSubview(commentCountView)
        countInfoStackView.addArrangedSubview(likeCountView)
    }
    
    private func addCommentsView() {
        commentsView.addSubview(commentsTitleLabel)
        commentsView.addSubview(separator)
        commentsView.addSubview(commentsCollectionView)
        
        commentsTitleLabel.edgesToSuperview(excluding: .bottom, insets: .init(top: 11, left: 15, bottom: 11, right: 15))
        
        separator.height(1)
        separator.edgesToSuperview(excluding: [.top, .bottom])
        separator.topToBottom(of: commentsTitleLabel).constant = 11
        
        commentsCollectionView.edgesToSuperview(excluding: .top)
        commentsCollectionView.topToBottom(of: separator)
        
        commentButtonView.addSubview(commentButton)
        commentButton.edgesToSuperview(insets: .init(top: 0, left: 15, bottom: 15, right: 15))
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Configure & SetLocalize
extension DetailViewController {
    
    private func configureContents() {
        view.backgroundColor = .appSecondaryBackground
        commentsCollectionView.delegate = self
        commentsCollectionView.dataSource = self
        
        commentCountView.setIcon = .icComment.withRenderingMode(.alwaysTemplate)
        likeCountView.setIcon = .icHeart.withRenderingMode(.alwaysTemplate)
        
        commentButton.setTitle(L10n.Detail.addComment, for: .normal)
        navigationController?.navigationBar.topItem?.backButtonTitle = L10n.General.back
        
        let rightBarItem = UIBarButtonItem(image: .icShare,
                                           style: .done,
                                           target: self,
                                           action: #selector(rightBarButtonTapped))
        navigationItem.setRightBarButton(rightBarItem, animated: true)
    }
    
    private func setLocalize() {
        commentCountView.setInfo = L10n.Detail.comment
        likeCountView.setInfo = L10n.Detail.like
        
        necessariesView.setImage = .icRestaurant
        necessariesView.setTitleText = L10n.Detail.necessaries
        
        stagesView.setTitleText = L10n.Detail.stages
        stagesView.setImage = .icClock
    }
    
    private func fillData() {
        navigationItem.title = viewModel.titleRecipeName
        headerView.fillHeaderData(headerData: viewModel.headerCellItems)
        
        titleView.setRecipeText = viewModel.titleRecipeName
        titleView.setCategoryText = viewModel.titleCategoryName
        titleView.setTimeText = viewModel.titleTimeText
        
        commentCountView.setCount = viewModel.commentCount
        likeCountView.setCount = viewModel.likeCount
        likeCountView.setIconColor = viewModel.isLiked ? .appRed : .appCinder
        
        userView.username = viewModel.username
        userView.recipeAndFollowerCountText = viewModel.userRecipeAndFollower
        userView.userImageUrl = viewModel.userImageUrl
        userView.isFollowing = viewModel.isFollowing
        
        necessariesView.setImageSubtitle = viewModel.numberOfPerson
        necessariesView.setInfoText = viewModel.necessaries
        
        stagesView.setImageSubtitle = viewModel.time
        stagesView.setInfoText = viewModel.stages
        
        if DefaultsKey.userId.value == viewModel.userId {
            userView.isFollowButtonHidden = true
        }
    }
}

// MARK: - SubscribeViewModel
extension DetailViewController {
    
    private func subscribeViewModel() {
        viewModel.reloadDetailData = { [weak self] in
            self?.fillData()
        }
        
        viewModel.reloadCommentData = { [weak self] in
            self?.commentsCollectionView.reloadData()
        }
        
        likeCountView.iconTappedAction = { [weak self] in
            guard let self = self else { return }
            self.viewModel.likeButtonTapped()
        }
    }
}

// MARK: - Action
extension DetailViewController {
    
    @objc
    private func commentButtonTapped() {
        viewModel.commentButtonTapped()
    }
    
    @objc
    private func rightBarButtonTapped() {
        let image = headerView.recipeImageData[headerView.pageControl.currentPage]
        let url = headerView.recipeUrlData[headerView.pageControl.currentPage]

        let activityVC = UIActivityViewController(activityItems: [image, URL(string: url)], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.numberOfItemsAt(section: 0) == 0 { return 1 }
        return viewModel.numberOfItemsAt(section: 0) > 3 ? 3 : viewModel.numberOfItemsAt(section: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.numberOfItemsAt(section: 0) == 0 {
            let cell: EmptyCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setInfoLabelText = L10n.Detail.noComment
            return cell
        }
        
        let cell: CommentCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = viewModel.cellItemAt(indexPath: indexPath)
        cell.set(with: cellItem)
        cell.ownerButtonHidden = true
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate { }
