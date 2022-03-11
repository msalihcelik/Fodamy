//
//  HomeViewController.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 7.03.2022.
//

final class HomeViewController: BaseViewController<HomeViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
