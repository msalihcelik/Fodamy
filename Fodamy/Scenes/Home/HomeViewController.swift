//
//  HomeViewController.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 7.03.2022.
//

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    private lazy var segmentView: Segmentio = {
        let segmentView = Segmentio()
        segmentView.setup(content: [SegmentioItem(title: viewModel.segmentedControlTitles[0], image: nil),
                                    SegmentioItem(title: viewModel.segmentedControlTitles[1], image: nil)], style: .onlyLabel, options: .options())
        return segmentView
    }()
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private lazy var subViewControllers: [UIViewController] = {
        return self.preparedViewControllers()
    }()
    
    private let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setSegmentHandler()
        configureContents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarItem.image = .icHome
        
        let rightBarItem = UIBarButtonItem(image: .icLogout.withAlignmentRectInsets(.init(top: 0, left: 0, bottom: -2, right: 0)),
                                           style: .done,
                                           target: nil,
                                           action: nil)
        navigationItem.setRightBarButton(rightBarItem, animated: true)
        navigationItem.titleView = AppTitleView(image: .imgLogoFodamy, insets: .bottom(10))
    }
}

// MARK: - UILayout
extension HomeViewController {
    
    private func addSubViews() {
        definesPresentationContext = true
        view.addSubview(pageViewController.view)
        view.addSubview(segmentView)
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        segmentView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        segmentView.height(46)
        pageViewController.view.edgesToSuperview(excluding: .top, usingSafeArea: true)
        pageViewController.view.topToBottom(of: segmentView)
    }
}

// MARK: - Configure
extension HomeViewController {
    
    private func configureContents() {
        view.backgroundColor = .appSecondaryBackground
        segmentView.backgroundColor = .appWhite
        segmentView.selectedSegmentioIndex = viewModel.selectedSegmentIndex
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.setViewControllers([subViewControllers[viewModel.selectedSegmentIndex]],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
    }
}

// MARK: - Helper
extension HomeViewController {
    
    private func preparedViewControllers() -> [UIViewController] {
        let editorChoiceRouter = RecipesRouter()
        let editorChoiceViewModel = RecipesViewModel(recipesListingType: .editorChoiceRecipes, router: editorChoiceRouter)
        let editorChoiceviewController = RecipesViewController(viewModel: editorChoiceViewModel)
        editorChoiceRouter.viewController = editorChoiceviewController
        
        let lastAddedRouter = RecipesRouter()
        let lastAddedRecipesViewModel = RecipesViewModel(recipesListingType: .lastAddedRecipes, router: lastAddedRouter)
        let lastAddedRecipesviewController = RecipesViewController(viewModel: lastAddedRecipesViewModel)
        lastAddedRouter.viewController = lastAddedRecipesviewController
        
        return [editorChoiceviewController, lastAddedRecipesviewController]
    }
    
    private func setSegmentHandler() {
        segmentView.valueDidChange = { [weak self] _, segmentIndex in
            guard let self = self else { return }
            var direction: UIPageViewController.NavigationDirection = .forward
            if segmentIndex < self.viewModel.selectedSegmentIndex {
                direction = .reverse
            }
            self.pageViewController.setViewControllers([self.subViewControllers[segmentIndex]], direction: direction, animated: true, completion: nil)
            self.viewModel.selectedSegmentIndex = segmentIndex
        }
    }
}

// MARK: - UIPageViewController
extension HomeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex <= 0 {
            return nil
        }
        
        return subViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex >= subViewControllers.count - 1 {
            return nil
        }
        return subViewControllers[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if completed {
            if let currentViewController = pageViewController.viewControllers?.first,
               let index = subViewControllers.firstIndex(of: currentViewController) {
                segmentView.selectedSegmentioIndex = index
            }
        }
    }
}
