//
//  Loading.swift.swift
//  desafio-ios-matheus-frança
//
//  Created by matheus.s.franca on 24/06/20.
//  Copyright © 2020 matheus.s.franca. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import UIKit

class LoadingOverlay {

var overlayView = UIView()
var activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }

    func showOverlay(view: UIView) {
        let navBarHeight = UINavigationController().navigationBar.frame.size.height
        overlayView.frame = CGRect(x: 0, y: -navBarHeight, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        overlayView.backgroundColor = .clear

        activityIndicator.type = .circleStrokeSpin
        activityIndicator.color = .themeColor
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)

        overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)

        activityIndicator.startAnimating()
    }

    func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
