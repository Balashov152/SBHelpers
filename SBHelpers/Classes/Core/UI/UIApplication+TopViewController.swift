//
//  UIApplication+Ex.swift
//  BubbleComics
//
//  Created by Hlopotin Andrey on 03/04/2019.
//  Copyright © 2019 Bubble. All rights reserved.
//

import Foundation
import UIKit

public extension UIApplication {
    class public var topViewController: UIViewController? {
        return getTopViewController(base: shared.keyWindow?.rootViewController)
    }

    private class func getTopViewController(base: UIViewController?) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
