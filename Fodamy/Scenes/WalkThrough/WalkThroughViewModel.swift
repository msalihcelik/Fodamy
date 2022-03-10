//
//  WalkThroughViewModel.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 9.03.2022.
//

protocol WalkThroughViewDataSource {
    var numberOfItems: Int { get }
    
    func cellItemAt(indexPath: IndexPath) -> WalkThroughCellProtocol
}

protocol WalkThroughViewEventSource {}

protocol WalkThroughViewProtocol: WalkThroughViewDataSource, WalkThroughViewEventSource {}

final class WalkThroughViewModel: BaseViewModel<WalkThroughRouter>, WalkThroughViewProtocol {
    
    var numberOfItems: Int {
        return cellItems.count
    }
    
    func cellItemAt(indexPath: IndexPath) -> WalkThroughCellProtocol {
        return cellItems[indexPath.row]
    }
    
    private let cellItems: [WalkThroughCellProtocol] = [WalkThroughCellModel(image: .imgWalkthrough1,
                                                                             titleText:
                                                                                L10n.WalkThrough.firstTitle,
                                                                             descriptionText: L10n.WalkThrough.descriptionText),
                                                        WalkThroughCellModel(image: .imgWalkthrough2,
                                                                             titleText:
                                                                                L10n.WalkThrough.secondTitle,
                                                                             descriptionText: L10n.WalkThrough.descriptionText),
                                                        WalkThroughCellModel(image: .imgWalkthrough3,
                                                                             titleText:
                                                                                L10n.WalkThrough.thirdTitle,
                                                                             descriptionText: L10n.WalkThrough.descriptionText),
                                                        WalkThroughCellModel(image: .imgWalkthrough4,
                                                                             titleText:
                                                                                L10n.WalkThrough.lastTitle,
                                                                             descriptionText: L10n.WalkThrough.descriptionText)]
}

// MARK: - Actions
extension WalkThroughViewModel {
    
    func didFinishWalkThroughScene() {
        DefaultsKey.isWalkThroughCompleted.value = true
        router.placeOnWindowHome()
    }
}
