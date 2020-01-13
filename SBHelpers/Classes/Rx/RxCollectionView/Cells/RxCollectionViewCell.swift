//
//  RxCollectionViewCell.swift
//  SellFashion
//
//  Created by Sergey Balashov on 13/08/2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class RxCollectionViewCell: UICollectionViewCell, RxViewModable {
    var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
        commonInit()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    open func commonInit() {}
    func setupWith(viewModel _: RowViewModel) {}
}
