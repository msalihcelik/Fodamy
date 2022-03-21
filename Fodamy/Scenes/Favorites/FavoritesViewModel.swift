//
//  FavoritesViewModel.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 16.03.2022.
//

protocol FavoritesViewDataSource {
    func numberOfItemsAt(section: Int) -> Int
    func cellItemAt(indexPath: IndexPath) -> FavoritesCellProtocol
}

protocol FavoritesViewEventSource {
    var reloadData: VoidClosure? { get set }
}

protocol FavoritesViewProtocol: FavoritesViewDataSource, FavoritesViewEventSource {}

final class FavoritesViewModel: BaseViewModel<FavoritesRouter>, FavoritesViewProtocol {
    
    var page = 1
    var isRequestEnabled = false
    var isPagingEnabled = false
    var reloadData: VoidClosure?
    private var cellItems: [FavoritesCellModel] = []
    
    func numberOfItemsAt(section: Int) -> Int {
        return cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> FavoritesCellProtocol {
        return cellItems[indexPath.row]
    }
    
    func getFavorites() {
        let request = GetRecipeCategoriesRequest(page: page)
        self.isRequestEnabled = false
        if page == 1 { showActivityIndicatorView?() }
        dataProvider.request(for: request) { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicatorView?()
            self.isRequestEnabled = true
            switch result {
            case .success(let response):
                let cellItems = response.data.map({ FavoritesCellModel(data: $0) })
                self.cellItems.append(contentsOf: cellItems)
                self.page += 1
                self.isPagingEnabled = response.pagination.currentPage < response.pagination.lastPage
                self.reloadData?()
            case .failure(let error):
                self.showWarningToast?(error.localizedDescription)
            }
        }
    }
    
    func pullToRefresh() {
        self.cellItems.removeAll()
        self.page = 1
        self.getFavorites()
    }
    
}
