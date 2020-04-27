//
//  UICollectionView+Ex.swift
//  SellFashion
//
//  Created by Sergey on 19/07/2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import class Foundation.Bundle
import struct Foundation.IndexPath

import class UIKit.UICollectionView
import class UIKit.UICollectionViewCell
import class UIKit.UINib

import struct UIKit.CGFloat
import struct UIKit.CGPoint
import struct UIKit.UIEdgeInsets

public extension UICollectionView {
    /// return width minus left and right instets
    var contentWidth: CGFloat {
        return frame.width - contentInset.left - contentInset.right
    }

    /// return height minus top and bottom instets
    var contentHeight: CGFloat {
        return frame.height - contentInset.top - contentInset.bottom
    }

    func scrollToTop(animated: Bool) {
        setContentOffset(CGPoint(x: -contentInset.left, y: -adjustedContentInset.top), animated: animated)
    }

    /// return width for one Item for create square item for required number of columns
    func widthForItem(sectionInsets: UIEdgeInsets, numberOfColumns: CGFloat, interItemSpacing: CGFloat) -> CGFloat {
        assert(numberOfColumns > 0, "wrong numberOfColumns, should be gretest or equal 1")
        let margins = (numberOfColumns - 1) * interItemSpacing
        let width = contentWidth - sectionInsets.left - sectionInsets.right - margins
        return width / numberOfColumns
    }
}

public extension UICollectionView {
    func register<T>(cell: T.Type) where T: UICollectionViewCell {
        register(cell, forCellWithReuseIdentifier: "\(cell)")
    }

    func register<T>(nib: T.Type) where T: UICollectionViewCell {
        register(UINib(nibName: "\(nib)", bundle: Bundle(for: nib)), forCellWithReuseIdentifier: "\(nib)")
    }

    func register<T>(cell: T.Type, forSupplementaryViewOfKind kind: String) where T: UICollectionReusableView {
        register(cell, forSupplementaryViewOfKind: kind, withReuseIdentifier: "\(cell)")
    }

    func register<T>(nib: T.Type, forSupplementaryViewOfKind kind: String) where T: UICollectionReusableView {
        register(UINib(nibName: "\(nib)", bundle: Bundle(for: nib)),
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: "\(nib)")
    }

    /// return generec class cell for indexPath for name class and reuse Identifier on name class
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as! T // swiftlint:disable:this force_cast
    }

    /// return generec class cell for row in 0 sections for name class and reuse Identifier on name class
    func dequeueReusableCell<T: UICollectionViewCell>(for row: Int) -> T {
        let indexPath = IndexPath(row: row, section: 0)
        return dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as! T // swiftlint:disable:this force_cast
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(T.self)", for: indexPath) as! T // swiftlint:disable:this force_cast
    }
}
