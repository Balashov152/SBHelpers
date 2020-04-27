//
//  UITableView+Cell.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Sellfashion. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    public func dequeueReusableViewModable<T>(cellType: RxTableViewCell.Type, for indexPath: IndexPath) -> T? {
        guard let viewModelble = dequeueReusableCell(withIdentifier: "\(cellType)", for: indexPath) as? RxViewModable else {
            assertionFailure("Cell is not RxViewModable")
            return dequeueReusableViewModable(cellType: RxTableViewCell.self, for: indexPath)
        }
        return viewModelble as? T
    }
}
