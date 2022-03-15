//
//  RecipesViewModel.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 14.03.2022.
//

protocol RecipesViewDataSource {
    var numberOfItems: Int { get }
    
    func cellItem(for indexPath: IndexPath) -> RecipeCellProtocol
}

protocol RecipesViewEventSource {
    var didSuccessFetchRecipes: VoidClosure? { get set }
}

protocol RecipesViewProtocol: RecipesViewDataSource, RecipesViewEventSource {
    func fetchRecipesListingType()
    func fetchMorePages()
}

final class RecipesViewModel: BaseViewModel<RecipesRouter>, RecipesViewProtocol {
    
    var cellItems: [RecipeCellProtocol] = []
    var page = 1
    var title: String?
    
    var isRequestEnabled = false
    var isPagingEnabled = false

    var recipesListingType: RecipesListingType
    var didSuccessFetchRecipes: VoidClosure?
    
    enum RecipesListingType {
        case editorChoiceRecipes
        case lastAddedRecipes
        case categoryRecipes(categoryId: Int)
    }
    
    init(recipesListingType: RecipesListingType, router: RecipesRouter) {
        self.recipesListingType = recipesListingType
        super.init(router: router)
    }
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func cellItem(for indexPath: IndexPath) -> RecipeCellProtocol {
        let item = cellItems[indexPath.row]
        return item
    }
}

// MARK: - Network
extension RecipesViewModel {
    
    func fetchRecipesListingType() {
        switch recipesListingType {
        case .editorChoiceRecipes:
            getEditorChoice()
        case .lastAddedRecipes:
            getLastAdded()
        case .categoryRecipes(let categoryId):
            getCategory(categoryId: categoryId)
        }
    }
    
    private func getEditorChoice() {
        let request = GetEditorChoiceRequest(page: page)
        self.isRequestEnabled = false
        if page == 1 { showActivityIndicatorView?() }
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            self.isRequestEnabled = true
            switch result {
            case .success(let response):
                let cellItems = response.data.map({ RecipeCellModel(recipe: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.page += 1
                self.isPagingEnabled = response.pagination.currentPage < response.pagination.lastPage
                self.didSuccessFetchRecipes?()
            case .failure(let error):
                if self.page == 1 { self.showWarningToast?("\(error.localizedDescription) Lütfen ekranı yukarıdan aşağıya kaydırarak yenileyiniz.") }
            }
        }
    }
    
    private func getLastAdded() {
        let request = GetLastAddedRequest(page: page)
        self.isRequestEnabled = false
        if page == 1 { showActivityIndicatorView?() }
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            self.isRequestEnabled = true
            switch result {
            case .success(let response):
                let cellItems = response.data.map({ RecipeCellModel(recipe: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.page += 1
                self.isPagingEnabled = response.pagination.currentPage < response.pagination.lastPage
                self.didSuccessFetchRecipes?()
            case .failure(let error):
                if self.page == 1 { self.showWarningToast?("\(error.localizedDescription) Lütfen ekranı yukarıdan aşağıya kaydırarak yenileyiniz.") }
            }
        }
    }
    
    private func getCategory(categoryId: Int) {
        let request = GetCategoryRequest(page: page, categoryId: categoryId)
        self.isRequestEnabled = false
        if page == 1 { showActivityIndicatorView?() }
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            self.isRequestEnabled = true
            switch result {
            case .success(let response):
                let cellItems = response.data.map({ RecipeCellModel(recipe: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.page += 1
                self.isPagingEnabled = response.pagination.currentPage < response.pagination.lastPage
                self.didSuccessFetchRecipes?()
            case .failure(let error):
                if self.page == 1 { self.showWarningToast?("\(error.localizedDescription) Lütfen ekranı yukarıdan aşağıya kaydırarak yenileyiniz.") }
            }
        }
    }
  
    func fetchMorePages() {
        fetchRecipesListingType()
    }
}
