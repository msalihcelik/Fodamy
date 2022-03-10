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
    private let nextButton = CustomRedButton()
    
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
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .touchUpInside)
    }
    
    private func addNextButton() {
        view.addSubview(nextButton)
        nextButton.edgesToSuperview(excluding: .top, insets: .left(15) + .right(15), usingSafeArea: true)
        nextButton.topToBottom(of: pageControl, offset: 20)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func addCloseButton() {
        view.addSubview(closeButton)
        closeButton.edgesToSuperview(excluding: [.left, .bottom], insets: .top(25) + .right(20), usingSafeArea: true)
        closeButton.width(18)
        closeButton.height(18)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Configure and Localize
extension WalkThroughViewController {
    
    private func configureContents() {
        pageControl.numberOfPages = viewModel.numberOfItems
        pageControl.currentPageIndicatorTintColor = .appRed
        pageControl.pageIndicatorTintColor = .appRed.withAlphaComponent(0.3)
        collectionView.dataSource = self
        collectionView.delegate = self
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
            nextButton.setTitle(L10n.WalkThrough.next, for: .normal)
        } else {
            nextButton.setTitle(L10n.WalkThrough.start, for: .normal)
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

public class ButtonFactory {
    
    public enum Style {
        case large
        case medium
        case small
        
        var height: CGFloat {
            switch self {
            case .large: return 60
            case .medium: return 50
            case .small: return 40
            }
        }
        
        var fontSize: UIFont.FontSize {
            switch self {
            case .large: return .xLarge
            case .medium: return .medium
            case .small: return .medium
            }
        }
    }
    
    public static func createPrimaryButton(style: Style) -> UIButton {
        let button = UIButtonBuilder()
            .titleFont(.font(.nunitoBold, size: style.fontSize))
            .titleColor(.appWhite)
            .backgroundColor(.appRed)
            .cornerRadius(4)
            .build()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: style.height).isActive = true
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        return button
    }
    
    public static func createPrimaryBorderedButton(style: Style) -> UIButton {
        let button = UIButtonBuilder()
            .titleFont(.font(.nunitoBold, size: style.fontSize))
            .titleColor(.appRed)
            .backgroundColor(.appWhite)
            .cornerRadius(4)
            .borderWidth(2)
            .borderColor(UIColor.appRed.cgColor)
            .build()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: style.height).isActive = true
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        return button
    }
    
}

public class PageControl: UIPageControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    // swiftlint:disable fatal_error unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error unavailable_function
    
    private func configureContents() {
        pageIndicatorTintColor = UIColor.appRed.withAlphaComponent(0.3)
        currentPageIndicatorTintColor = .appRed
    }
}
