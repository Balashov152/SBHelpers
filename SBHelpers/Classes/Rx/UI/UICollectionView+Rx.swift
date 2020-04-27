//
//  UICollectionView+Rx.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Sellfashion. All rights reserved.
//

import struct Foundation.IndexPath
import class UIKit.UICollectionView

extension UICollectionView {
    public func dequeueReusableViewModable(cellType: RxCollectionViewCell.Type, for indexPath: IndexPath) -> RxViewModable {
        guard let viewModelble = dequeueReusableCell(withReuseIdentifier: "\(cellType)", for: indexPath) as? RxViewModable else {
            assertionFailure("Cell is not RxViewModable")
            return dequeueReusableViewModable(cellType: RxCollectionViewCellJ.self, for: indexPath)
        }
        return viewModelble
    }
}
