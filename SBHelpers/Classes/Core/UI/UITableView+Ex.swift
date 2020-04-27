//
//  UITableView+Ex.swift
//  SellFashion
//
//  Created by Sergey on 19/07/2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import class Foundation.Bundle
import class Foundation.DispatchQueue
import struct Foundation.IndexPath

import struct UIKit.CGPoint
import class UIKit.UIApplication
import class UIKit.UINib
import class UIKit.UITableView
import class UIKit.UITableViewCell

public extension UITableView {
    func register<T>(cell: T.Type) where T: UITableViewCell {
        register(cell, forCellReuseIdentifier: "\(cell)")
    }

    func register<T>(nib: T.Type) where T: UITableViewCell {
        register(UINib(nibName: "\(nib)", bundle: Bundle(for: nib)), forCellReuseIdentifier: "\(nib)")
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T // swiftlint:disable:this force_cast
    }

    func dequeueReusableCell<T: UITableViewCell>(for row: Int) -> T {
        let indexPath = IndexPath(row: row, section: 0)
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T // swiftlint:disable:this force_cast
    }

    func scrollToTop(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: -adjustedContentInset.top)
        setContentOffset(bottomOffset, animated: animated)
    }

    func scrollToBottom(animated: Bool) {
        DispatchQueue.main.async {
//            debugPrint("contentInset.bottom", self.adjustedContentInset.bottom)
//            debugPrint("contentInset.top", self.adjustedContentInset.top)
//            debugPrint("self.contentSize.height", self.contentSize.height)
//            debugPrint("self.bounds.size.height", self.bounds.size.height)
//            debugPrint("minus", self.bounds.size.height - self.contentInset.bottom - self.contentInset.top)
            let inset = self.adjustedContentInset
            guard self.contentSize.height > self.bounds.size.height - inset.bottom - inset.top else { return }
            let bottomInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            let yOffset = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom + bottomInset
            let bottomOffset = CGPoint(x: 0, y: yOffset)
//            debugPrint("bottomOffset", bottomOffset)
            self.setContentOffset(bottomOffset, animated: animated)
        }
    }
}
