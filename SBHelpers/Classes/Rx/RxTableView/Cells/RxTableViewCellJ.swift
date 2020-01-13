//
//  RxTableViewCellJ.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Egor Otmakhov. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

open class RxTableViewCell: UITableViewCell {
    public var disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectionStyle = .none
        backgroundColor = .clear
        commonInit()
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    open func commonInit() {}
}
