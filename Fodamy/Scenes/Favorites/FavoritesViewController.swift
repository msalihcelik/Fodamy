//
//  FavoritesViewController.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 16.03.2022.
//

final class FavoritesViewController: BaseViewController<FavoritesViewModel> {
    
    private let collectionView = UICollectionViewBuilder()
        .backgroundColor(.clear)
        .registerCell(FavoritesCell.self, reuseIdentifier: FavoritesCell.reuseIdentifier)
        .build()
    private let refreshControl = UIRefreshControl()
    private var loadingFooterView: ActivityIndicatorFooterView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        viewModel.getFavorites()
        subscribeViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let rightBarItem = UIBarButtonItem(image: .icLogout.withAlignmentRectInsets(.init(top: 0, left: 0, bottom: -2, right: 0)),
                                           style: .done,
                                           target: nil,
                                           action: nil)
        navigationItem.setRightBarButton(rightBarItem, animated: true)
        navigationItem.titleView = AppTitleView(image: .imgLogoFodamy, insets: .bottom(10))
    }
}

// MARK: - UILayout
extension FavoritesViewController {
    
    private func addSubViews() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview()
    }
}

// MARK: - Configure & SetLocalize
extension FavoritesViewController {
    
    private func configureContents() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerFooter(ActivityIndicatorFooterView.self)
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        view.backgroundColor = .appSecondaryBackground
    }
}

// MARK: - SubscribeViewModel
extension FavoritesViewController {
    
    private func subscribeViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - Action
extension FavoritesViewController {
    
    @objc
    private func pullToRefresh() {
        if refreshControl.isRefreshing {
            viewModel.pullToRefresh()
            refreshControl.endRefreshing()
        }
    }
}

// MARK: - ScrollViewDelegate
extension FavoritesViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y

        if position > scrollView.contentSize.height - scrollView.frame.size.height && viewModel.isPagingEnabled && viewModel.isRequestEnabled {
            viewModel.getFavorites()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsAt(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FavoritesCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = viewModel.cellItemAt(indexPath: indexPath)
        cell.set(with: cellItem)
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

// MARK: - UICollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate { }

// swiftlint:disable line_length
// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        
        let height: CGFloat = viewModel.isPagingEnabled ? 100 : 0
        return CGSize(width: collectionView.bounds.size.width, height: height)
    }
}
 // swiftlint:enable line_length
