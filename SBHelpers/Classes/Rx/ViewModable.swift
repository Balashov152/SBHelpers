//
//  RxViewModable.swift
//  SellFashion
//
//  Created by Sergey Balashov on 22/07/2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import RxCocoa
import RxDataSources
import UIKit

public protocol RowViewModel {}

public protocol RxViewModable: AnyObject {
    func setupWith(viewModel: RowViewModel)
}

public struct ConfigureViewModable<S> where S: SectionModelType {
    
    public init() {}
    
    public let configureCell: (TableViewSectionedDataSource<S>, UITableView, IndexPath, TableSectionItem) -> UITableViewCell = { (_, tableView, indexPath, item) -> UITableViewCell in
        guard let cell: RxViewModable = tableView.dequeueReusableViewModable(cellType: item.cellType, for: indexPath) else { return .init() }
        cell.setupWith(viewModel: item)
        return cell as? RxTableViewCell ?? RxTableViewCell()
    }

    public typealias CollecitonConfigureCell = (CollectionViewSectionedDataSource<S>, UICollectionView, IndexPath, CollectionSectionItem) -> UICollectionViewCell
    public let collectionConfigureCell: CollecitonConfigureCell = { (_, collectionView, indexPath, item) -> UICollectionViewCell in
        let cell: RxViewModable = collectionView.dequeueReusableViewModable(cellType: item.cellType, for: indexPath)
        cell.setupWith(viewModel: item)
        return cell as? RxCollectionViewCell ?? RxCollectionViewCell()
    }
}
