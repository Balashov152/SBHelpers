//
//  NibView.swift
//
//
//  Created by Sergey on 19/09/2018.
//  Copyright © 2018 Sergey Balashov. All rights reserved.
//

import Foundation
import UIKit

public class NibView: UIView {
    var view: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Setup view from .xib file
        xibSetup()
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Setup view from .xib file
        xibSetup()
        commonInit()
    }

    open func commonInit() {}
}

private extension NibView {
    private func xibSetup() {
        backgroundColor = UIColor.clear
        view = loadNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Adding custom subview on top of our view
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view!]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view!]))
    }
}

extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
}
