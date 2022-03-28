//
//  FavoritesCell.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 16.03.2022.
//

public class FavoritesCell: UICollectionViewCell, ReusableView {
    
    weak var viewModel: FavoritesCellProtocol?
    
    private let headerView = UIViewBuilder()
        .backgroundColor(.appWhite)
        .build()
    private var headerLeftImage = UIImageViewBuilder()
        .contentMode(.scaleAspectFit)
        .build()
    private var headerCategoryLabel = UILabelBuilder()
        .font(.font(.nunitoBold, size: .medium))
        .build()
    private let headerRightButton = UIButtonBuilder()
        .tintColor(.appRed)
        .titleFont(.font(.nunitoBold, size: .small))
        .build()
    private let separatorLine = UIViewBuilder()
        .backgroundColor(.appSecondaryBackground)
        .build()
    
    private let collectionView = UICollectionViewBuilder()
        .scrollDirection(.horizontal)
        .backgroundColor(.white)
        .showsVerticalScrollIndicator(false)
        .build()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
        setLocalize()
        subscribeViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubViews()
        configureContents()
        setLocalize()
        subscribeViewModel()
    }
    
    public func set(with viewModel: FavoritesCellProtocol, seeDetails: IntClosure?, seeAll: ((Int, String) -> Void)?) {
        self.viewModel = viewModel
        headerCategoryLabel.text = viewModel.headerCategoryName
        headerLeftImage.setImage(viewModel.headerLeftImageURL)
        self.collectionView.reloadData()
        self.viewModel?.seeDetails = seeDetails
        self.viewModel?.seeAll = seeAll
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        headerLeftImage.image = nil
        headerCategoryLabel.text = nil
    }
}

// MARK: - UILayout
extension FavoritesCell {
    
    private func addSubViews() {
        addHeaderView()
        addHeaderSubViews()
        addSeparatorLine()
        addCollectionView()
    }
    
    private func addHeaderView() {
        contentView.addSubview(headerView)
        headerView.edgesToSuperview(excluding: .bottom)
    }
    
    private func addHeaderSubViews() {
        headerView.addSubview(headerLeftImage)
        headerLeftImage.centerYToSuperview()
        headerLeftImage.leftToSuperview(offset: 15)
        
        headerView.addSubview(headerCategoryLabel)
        headerCategoryLabel.centerY(to: headerLeftImage)
        headerCategoryLabel.leftToRight(of: headerLeftImage, offset: 5)
        
        headerView.addSubview(headerRightButton)
        headerRightButton.centerY(to: headerCategoryLabel)
        headerRightButton.rightToSuperview(offset: -15)
    }
    
    private func addSeparatorLine() {
        contentView.addSubview(separatorLine)
        separatorLine.edgesToSuperview(excluding: [.top, .bottom])
        separatorLine.topToBottom(of: headerView)
    }
    
    private func addCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.edgesToSuperview(excluding: .top)
        collectionView.topToBottom(of: separatorLine)
    }
}

// MARK: - Configure & SetLocalize
extension FavoritesCell {
    
    private func configureContents() {
        headerView.height(44)
        headerLeftImage.size(.init(width: 24, height: 24))
        separatorLine.height(1)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoritesRecipeCell.self)
        
        headerRightButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
    }
    
    private func setLocalize() {
        headerRightButton.setTitle(L10n.Favorites.seeAll, for: .normal)
    }
}

// MARK: - Actions
extension FavoritesCell {
    
    @objc
    private func seeAllButtonTapped() {
        guard let categoryId = viewModel?.categoryId,
              let categoryName = viewModel?.headerCategoryName
        else { return }
        viewModel?.seeAll?(categoryId, categoryName)
    }
}

// MARK: - Subscribe
extension FavoritesCell {
    
    private func subscribeViewModel() {
        viewModel?.reloadData = {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getCellCount() ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavoritesRecipeCell = collectionView.dequeueReusableCell(for: indexPath)
        if let cellItem = viewModel?.cellItems[indexPath.row] {
            cell.set(with: cellItem)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FavoritesCell: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel?.cellItems[indexPath.row].recipeId else { return }
        viewModel?.seeDetails?(id)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 150, height: 195)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return .left(15)
    }
}
