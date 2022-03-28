//
//  RecipesViewController.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 14.03.2022.
//

final class RecipesViewController: BaseViewController<RecipesViewModel> {
    
    private let collectionView = UICollectionViewBuilder()
        .backgroundColor(.clear)
        .build()
    private let refreshControl = UIRefreshControl()
    private var loadingFooterView: ActivityIndicatorFooterView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        subscribeViewModelEvents()
        viewModel.fetchRecipesListingType()
    }
}

// MARK: - UILayout
extension RecipesViewController {
    
    private func addSubViews() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
    }
}

// MARK: - Configure
extension RecipesViewController {
    
    private func configureContents() {
        view.backgroundColor = .appSecondaryBackground
        navigationItem.title = viewModel.title
        refreshControl.addTarget(self, action: #selector(pullToRefreshValueChanged), for: .valueChanged)
        navigationController?.navigationBar.topItem?.backButtonTitle = L10n.General.back
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecipeCell.self)
        collectionView.registerFooter(ActivityIndicatorFooterView.self)
        collectionView.refreshControl = refreshControl
    }
}

// MARK: - SubscribeViewModel
extension RecipesViewController {
    
    private func subscribeViewModelEvents() {
        viewModel.didSuccessFetchRecipes = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - Actions
extension RecipesViewController {
    
    @objc
    private func pullToRefreshValueChanged() {
        viewModel.cellItems.isEmpty ? viewModel.fetchRecipesListingType() : nil
        refreshControl.endRefreshing()
    }
}

// MARK: - UIScrollViewDelegate
extension RecipesViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > scrollView.contentSize.height - scrollView.frame.size.height, viewModel.isPagingEnabled, viewModel.isRequestEnabled {
            viewModel.fetchMorePages()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension RecipesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecipeCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellViewModel = viewModel.cellItem(for: indexPath)
        cell.set(viewModel: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let footer: ActivityIndicatorFooterView = collectionView.dequeueReusableCell(ofKind: kind, for: indexPath)
        loadingFooterView = footer
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingFooterView?.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplayingSupplementaryView view: UICollectionReusableView,
                        forElementOfKind elementKind: String,
                        at indexPath: IndexPath) {
        
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingFooterView?.activityIndicator.stopAnimating()
        }
    }
}

// swiftlint:disable line_length
// MARK: - UICollectionViewDelegateFlowLayout
extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRecipe(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWitdh = view.frame.width
        let recipeImageHeight = cellWitdh - 30
        let otherCellItemsHeight = CGFloat(175)
        let cellHeight = recipeImageHeight + otherCellItemsHeight
        return CGSize(width: cellWitdh, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        
        let height: CGFloat = viewModel.isPagingEnabled ? 100 : 0
        return CGSize(width: collectionView.bounds.size.width, height: height)
    }
}
// swiftlint:enable line_length
