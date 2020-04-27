//
//  RxViewModable.swift
//  SellFashion
//
//  Created by Sergey Balashov on 22/07/2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
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

    public typealias TableViewConfigureCell = (TableViewSectionedDataSource<S>, UITableView, IndexPath, TableSectionItem) -> RxTableViewCell
    public let configureCell: TableViewConfigureCell = { (_, tableView, indexPath, item) -> RxTableViewCell in
        guard let cell: RxViewModable = tableView.dequeueReusableViewModable(cellType: item.cellType, for: indexPath) else { return .init() }
        cell.setupWith(viewModel: item)
        return cell as? RxTableViewCell ?? RxTableViewCell()
    }

    public typealias CollecitonConfigureCell = (CollectionViewSectionedDataSource<S>, UICollectionView, IndexPath, CollectionSectionItem) -> RxCollectionViewCell
    public let collectionConfigureCell: CollecitonConfigureCell = { (_, collectionView, indexPath, item) -> RxCollectionViewCell in
        let cell: RxViewModable = collectionView.dequeueReusableViewModable(cellType: item.cellType, for: indexPath)
        cell.setupWith(viewModel: item)
        return cell as? RxCollectionViewCell ?? RxCollectionViewCell()
    }
}
