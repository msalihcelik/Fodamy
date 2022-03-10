//
//  AppRouter.swift
//  Fodamy
//
//  Created by Mehmet Salih ÇELİK on 7.03.2022.
//

final class AppRouter: Router, AppRouter.Routes {
    
    typealias Routes = HomeRoute & WalkThroughRoute
    weak var window: UIWindow?
    
    static let shared = AppRouter()
    
    private func topViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    func startApp() {
        if DefaultsKey.isWalkThroughCompleted.value == true {
            AppRouter.shared.placeOnWindowHome()
        } else {
            AppRouter.shared.placeOnWindowWalkThrough()
        }
    }
}
