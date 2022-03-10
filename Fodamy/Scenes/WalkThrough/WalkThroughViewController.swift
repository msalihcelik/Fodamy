//
//  WalkThroughViewController.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 9.03.2022.
//

final class WalkThroughViewController: BaseViewController<WalkThroughViewModel> {
    
    private let closeButton = UIButtonBuilder()
        .image(UIImage.icClose.withRenderingMode(.alwaysTemplate))
        .tintColor(.appCinder)
        .build()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(WalkThroughCell.self)
        return collectionView
    }()
    private let pageControl = UIPageControlBuilder()
        .build()
    private let nextButton = AppButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        setLocalize()
    }
}

// MARK: - UILayout
extension WalkThroughViewController {
    
    private func addSubViews() {
        addCollectionView()
        addPageControl()
        addNextButton()
        addCloseButton()
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
    }
    
    private func addPageControl() {
        view.addSubview(pageControl)
        pageControl.topToBottom(of: collectionView)
        pageControl.centerXToSuperview()
    }
    
    private func addNextButton() {
        view.addSubview(nextButton)
        nextButton.edgesToSuperview(excluding: .top, insets: .left(15) + .right(15), usingSafeArea: true)
        nextButton.topToBottom(of: pageControl, offset: 20)
    }
    
    private func addCloseButton() {
        view.addSubview(closeButton)
        closeButton.edgesToSuperview(excluding: [.left, .bottom], insets: .top(25) + .right(20), usingSafeArea: true)
        closeButton.width(18)
        closeButton.height(18)
    }
}

// MARK: - Configure and Localize
extension WalkThroughViewController {
    
    private func configureContents() {
        collectionView.dataSource = self
        collectionView.delegate = self
        pageControl.numberOfPages = viewModel.numberOfItems
        pageControl.currentPageIndicatorTintColor = .appRed
        pageControl.pageIndicatorTintColor = .appRed.withAlphaComponent(0.3)
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private func setLocalize() {
        nextButton.setTitle(L10n.WalkThrough.next, for: .normal)
    }
}

// MARK: - Actions
extension WalkThroughViewController {
    
    @objc
    private func nextButtonTapped() {
        if pageControl.currentPage == viewModel.numberOfItems - 1 {
            viewModel.didFinishWalkThroughScene()
        }
        
        let nextIndex = min(pageControl.currentPage + 1, viewModel.numberOfItems - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc
    private func pageControlValueChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        collectionView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(current), y: 0), animated: true)
    }
    
    @objc
    private func closeButtonTapped() {
        viewModel.didFinishWalkThroughScene()
    }
}

// MARK: - UIScrollViewDelegate
extension WalkThroughViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
        
        if pageControl.currentPage == viewModel.numberOfItems - 1 {
            nextButton.setTitle(L10n.WalkThrough.start, for: .normal)
        } else {
            nextButton.setTitle(L10n.WalkThrough.next, for: .normal)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension WalkThroughViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WalkThroughCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = viewModel.cellItemAt(indexPath: indexPath)
        cell.set(viewModel: cellItem)
        return cell
    }
}

// swiftlint:disable line_length
// MARK: - UICollectionViewDelegateFlowLayout
extension WalkThroughViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
}
// swiftlint:enable line_length
