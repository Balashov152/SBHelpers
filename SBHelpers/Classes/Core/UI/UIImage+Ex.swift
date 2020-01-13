//
//  UIImage+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 30/09/2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import UIKit

public extension UIImage {
    func jpegData(maxSizeKB: Int, compress: CGFloat = 1.0) -> Data? {
        if let data = jpegData(compressionQuality: compress) {
            let bcf = ByteCountFormatter()
            bcf.allowedUnits = [.useKB]
            bcf.countStyle = .file
            let string = bcf.string(fromByteCount: Int64(data.count))
            debugPrint("formatted result: \(string)")

            if (data.count / 1000) < maxSizeKB {
                return data
            }
        }
        return jpegData(maxSizeKB: maxSizeKB, compress: compress - 0.05)
    }

    func resizeImageSquare() -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }

        let size = CGSize(width: 1080, height: 1080)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
            return newImage
        }
        return nil
    }

    func resizeImage(image: UIImage, newWidth: CGFloat, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let scale = newWidth / image.size.width
            let newHeight = image.size.height * scale
            let size = CGSize(width: newWidth, height: newHeight)
            //        print("resize image: ", image.size, "new size: ", size)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
            if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
                DispatchQueue.main.async {
                    completion(newImage)
                }
            }
            UIGraphicsEndImageContext()
        }
    }
}
