//
//  HomeViewModel.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 7.03.2022.
//

import Foundation

protocol HomeViewDataSource {}

protocol HomeViewEventSource {}

protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {}

final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    
}
