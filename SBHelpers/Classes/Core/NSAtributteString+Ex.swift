//
//  NSAtributteString.swift
//  SellFashion
//
//  Created by Sergey Balashov on 28/08/2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import Foundation
import UIKit

public extension NSAttributedString {
    class func strike(value: String) -> NSAttributedString {
        NSAttributedString(string: "\(value)", attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
    }

    class func iconImage(_ iconImage: UIImage, titleFont: UIFont) -> NSAttributedString {
        let icon = NSTextAttachment()
        icon.bounds = CGRect(x: 0, y: (titleFont.capHeight - iconImage.size.height).rounded() / 2, width: iconImage.size.width, height: iconImage.size.height)
        icon.image = iconImage
        return NSAttributedString(attachment: icon)
    }
}
