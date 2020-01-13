//
//  ShareService.swift
//  SellFashion
//
//  Created by Sergey Balashov on 18.10.2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import UIKit

public struct ShareService {
    static public func share(controller: UIViewController?, items: [Any]) {
        let activity = UIActivityViewController(activityItems: items, applicationActivities: nil)
        controller?.present(activity, animated: true)
    }
}
