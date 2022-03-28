//
//  DetailHeaderView.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 24.03.2022.
//

public class DetailHeaderView: UIView {
    
    private let collectionView = UICollectionViewBuilder()
        .scrollDirection(.horizontal)
        .backgroundColor(.clear)
        .isPagingEnabled(true)
        .showsHorizontalScrollIndicator(false)
        .registerCell(DetailHeaderViewCell.self, reuseIdentifier: DetailHeaderViewCell.reuseIdentifier)
        .build()
    public let pageControl = UIPageControlBuilder()
        .build()
    
    public var recipeUrlData: [String] = []
    public var recipeImageData: [UIImageView] = []
    public var headerData: [DetailHeaderViewCellProtocol] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubViews()
        configureContents()
    }
}

// MARK: - UILayout
extension DetailHeaderView {
    
    private func addSubViews() {
        addCollectionView()
        addPageControl()
    }
    
    private func addCollectionView() {
        addSubview(collectionView)
        collectionView.edgesToSuperview()
    }
    
    private func addPageControl() {
        addSubview(pageControl)
        pageControl.bottom(to: collectionView)
        pageControl.centerX(to: collectionView)
    }
}

// MARK: - Configure
extension DetailHeaderView {
    
    private func configureContents() {
        backgroundColor = .appZircon
        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageControl.tintColor = .appWhite
        pageControl.pageIndicatorTintColor = UIColor.appRed.withAlphaComponent(0.3)
        pageControl.currentPageIndicatorTintColor = .appWhite
    }
    
    public func fillHeaderData(headerData: [DetailHeaderViewCellProtocol]) {
        self.recipeImageData.removeAll()
        self.headerData = headerData
        self.recipeUrlData = headerData.map({ $0.imageUrl })
        self.recipeUrlData.forEach { url in
            let imageView = UIImageView()
            imageView.setImage(url)
            DispatchQueue.main.async {
                self.recipeImageData.append(imageView)
                self.collectionView.reloadData()
            }
        }
        pageControl.numberOfPages = headerData.count
        pageControl.isHidden = pageControl.numberOfPages == 1
    }
    
}

// MARK: - UICollectionViewDelegate
extension DetailHeaderView: UICollectionViewDelegate { }

// MARK: - UICollectionViewDataSource
extension DetailHeaderView: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeImageData.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailHeaderViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let currentRecipeHeaderModel = headerData[indexPath.row]
        cell.set(with: currentRecipeHeaderModel, imageViews: recipeImageData, index: indexPath.row)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailHeaderView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

// MARK: - UIScrollViewDelegate
extension DetailHeaderView {

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
