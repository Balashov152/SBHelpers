//
//  UIApplication+StatusBarView.swift
//  Use and Go
//
//  Created by Sergey on 16.03.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation
import UIKit

public extension UIApplication {
    
    public var statusBarViewAnimationDuration: Double { 0.3 }
    
    /// Returns the status bar UIView
    public var statusBarView: UIView? {
        if #available(iOS 13.0, *) {} else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }

    public func changeStatusBar(alpha: CGFloat) {
        statusBarView?.alpha = alpha
    }

    public func hideStatusBar() {
        UIView.animate(withDuration: statusBarViewAnimationDuration) {
            self.statusBarView?.alpha = 0
        }
    }

    public func showStatusBar() {
        UIView.animate(withDuration: statusBarViewAnimationDuration) {
            self.statusBarView?.alpha = 1
        }
    }
}
