//
//  AuthNavigationController.swift
//  UIComponents
//
//  Created by Mehmet Salih ÇELİK on 1.04.2022.
//

public class AuthNavigationController: UINavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
    }
    
    #if DEBUG
    deinit {
        debugPrint("deinit \(self)")
    }
    #endif
}

// MARK: - Configure
extension AuthNavigationController {
    
    private func configureContents() {
        let backImage = UIImage.icBack
            .resize(to: .init(width: 11, height: 18))
            .withRenderingMode(.alwaysTemplate)
        
        navigationBar.isTranslucent = true
        navigationBar.tintColor = .appCinder
        navigationBar.barTintColor = .clear
        navigationBar.shadowImage = UIImage()
        navigationBar.backIndicatorImage = backImage
        navigationBar.shadowImage = UIImage()
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            appearance.backgroundColor = .clear

            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            navigationBar.compactAppearance = appearance
        }
    }
}
