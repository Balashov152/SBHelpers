//
//  UIImageView+SetImage.swift
//  SellFashion
//
//  Created by Sergey Balashov on 09.01.2020.
//  Copyright © 2020 Sellfashion. All rights reserved.
//

import struct Alamofire.DataResponse
import UIKit

public extension UIImageView {
    func newActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }

    func setImage(urlRequest request: URLRequest, result: ((DataResponse<UIImage>) -> Void)?) {
        af_cancelImageRequest()
        var activityIndicator: UIActivityIndicatorView! = subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView

        if activityIndicator == nil {
            activityIndicator = newActivityIndicator()

            addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            if image == nil {
                activityIndicator.startAnimating()
            }
        }

        image == nil ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()

        af_setImage(withURLRequest: request,
                    placeholderImage: nil,
                    filter: nil,
                    progress: { progress in
                        let inProgress = progress.fractionCompleted != 1.0
                        inProgress ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
                        if !inProgress {
                            activityIndicator.stopAnimating()
                        }
                    },
                    progressQueue: .main,
                    imageTransition: .crossDissolve(0.2), //
                    runImageTransitionIfCached: false, completion: { completion in
                        result?(completion)
                        activityIndicator.stopAnimating()

        })
    }
}
