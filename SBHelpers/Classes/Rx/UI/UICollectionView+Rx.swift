//
//  UICollectionView+Rx.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Egor Otmakhov. All rights reserved.
//

import class UIKit.UICollectionView

extension UICollectionView {
    func dequeueReusableViewModable(cellType: RxCollectionViewCell.Type, for indexPath: IndexPath) -> RxViewModable {
        guard let viewModelble = dequeueReusableCell(withReuseIdentifier: "\(cellType)", for: indexPath) as? RxViewModable else {
            assertionFailure("Cell is not RxViewModable")
            return dequeueReusableViewModable(cellType: RxCollectionViewCell.self, for: indexPath)
        }
        return viewModelble
    }
}
