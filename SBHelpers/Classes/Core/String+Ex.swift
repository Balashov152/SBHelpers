//
//  String+Ex.swift
//  BubbleComics
//
//  Created by Azov Vladimir on 22/02/2019.
//  Copyright © 2019 Bubble. All rights reserved.
//

import UIKit

public extension Optional where Wrapped == String {
    var orEmpty: String { self ?? "" }
}

public extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }

    func size(font: UIFont, constrainedToWidth width: CGFloat) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let attString = NSAttributedString(string: self, attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0, length: 0), nil, CGSize(width: width, height: .greatestFiniteMagnitude), nil)
    }

    func addCurrencySymbol() -> String {
        assert(!contains("₽"), "Duplicate currency")
        return self + " " + "₽"
    }

    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
