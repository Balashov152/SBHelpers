//
//  RxCollectionViewCellJ.swift
//  SellFashion
//
//  Created by Sergey Balashov on 13/08/2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

open class RxCollectionViewCell: UICollectionViewCell {
    public var disposeBag = DisposeBag()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    open override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    open func commonInit() {}
}
