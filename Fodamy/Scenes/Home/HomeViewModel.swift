//
//  HomeViewModel.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 7.03.2022.
//

protocol HomeViewDataSource {
    var segmentedControlTitles: [String] { get }
    var selectedSegmentIndex: Int { get }
}

protocol HomeViewEventSource {}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    
    var segmentedControlTitles: [String] = [L10n.Home.editorChoice,
                                            L10n.Home.lastAdded]
    var selectedSegmentIndex = 0
}
