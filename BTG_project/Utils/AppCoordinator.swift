//
//  AppCoordinator.swift
//  desafio-ios-matheus-frança
//
//  Created by matheus.s.franca on 22/06/20.
//  Copyright © 2020 matheus.s.franca. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    class func startViewController (newVC: UIViewController, parent: Any, animation: Bool = false) {
        if let window = parent as? UIWindow {
            window.rootViewController = newVC
        } else if let nav = parent as? UINavigationController {
            if animation {
                let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.reveal
                nav.view.layer.add(transition, forKey: nil)
            }
            nav.pushViewController(newVC, animated: true)
        } else if let controller = parent as? UIViewController {
            controller.present(newVC, animated: true, completion: nil)
        }
    }
    
    class func goToHome(parent: Any) {
        let startVc = HomeViewController()
        let navController = UINavigationController(rootViewController: startVc)
        AppCoordinator.startViewController(newVC: navController, parent: parent)
    }
    
    class func goToCurrencyList(parent: Any, delegate: CurrencyDelegate, originCurrency: Bool) {
        let vc = CurrenciesViewController()
        vc.delegate = delegate
        vc.originCurrency = originCurrency
        AppCoordinator.startViewController(newVC: vc, parent: parent, animation: true)
    }
}
