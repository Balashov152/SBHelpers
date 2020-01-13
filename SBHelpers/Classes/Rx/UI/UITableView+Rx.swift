//
//  UITableView+Rx.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Egor Otmakhov. All rights reserved.
//

import Foundation

extension UITableView {
    public func dequeueReusableViewModable(cellType: RxTableViewCell.Type, for indexPath: IndexPath) -> RxViewModable? {
        return dequeueReusableCell(withIdentifier: "\(cellType)", for: indexPath) as? RxViewModable
    }
}
