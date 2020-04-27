//
//  UIImage+Ex.swift
//  SellFashion
//
//  Created by Sergey Balashov on 30/09/2019.
//  Copyright © 2019 Sellfashion. All rights reserved.
//

import UIKit

public extension UIImage {
    func jpegData(maxSizeKB: Int, compress: CGFloat = 1.0) -> Data? {
        guard compress > 0 else { return nil }

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
        let maxSize = 1080 / UIScreen.main.scale
        let size = CGSize(width: maxSize, height: maxSize)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
            return newImage
        }
        return nil
    }

    func resizeImage(newWidth: CGFloat, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let scale = newWidth / self.size.width
            let newHeight = self.size.height * scale
            let size = CGSize(width: newWidth, height: newHeight)
            print("resize image: ", self.size, "new size: ", size)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

            let maxValue = max(newHeight, newWidth)
            UIColor.red.setFill()
            UIRectFill(CGRect(x: 0, y: 0, width: maxValue, height: maxValue))
            print("UIRectFill UIColor: ", self.size, "new maxValue: ", maxValue)

            self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

            if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
                DispatchQueue.main.async {
                    completion(newImage)
                }
            }
            UIGraphicsEndImageContext()
        }
    }

    func resizeSquare(backgroundColor color: UIColor) -> UIImage {
        defer {
            UIGraphicsEndImageContext()
        }
        let originalSize = size

        let maxSide = Swift.max(originalSize.width, originalSize.height)
        let squareSize = CGSize(width: maxSide, height: maxSide)
        let imageRect = originalSize.convertRectTo(newSize: squareSize)
        let colorRect = CGRect(origin: .zero, size: imageRect.size)

        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        format.opaque = true
        let newImage = UIGraphicsImageRenderer(bounds: colorRect, format: format).image { _ in
            color.setFill()
            UIBezierPath(rect: colorRect).fill()
            self.draw(in: CGRect(origin: imageRect.origin, size: originalSize))
        }

        return newImage
    }
}

extension CGSize {
    func convertRectTo(newSize: CGSize) -> CGRect {
        let cropAspect: CGFloat = newSize.width / newSize.height

        if newSize.width > newSize.height { // Landscape
            let cropWidth = width
            let cropHeight = width / cropAspect
            let posY = (height - cropHeight) / 2

            return CGRect(x: 0, y: posY, width: cropWidth, height: cropHeight)

        } else if newSize.width < newSize.height { // Portrait
            let cropHeight = height
            let cropWidth = height * cropAspect
            let posX = (width - cropWidth) / 2

            return CGRect(x: posX, y: 0, width: cropWidth, height: cropHeight)
        } else { // Square -> cropAspect = 1
            if width >= height { // Square on landscape (or square)
                let posY = (width - height) / 2
                return CGRect(x: 0, y: posY, width: width, height: width)

            } else { // Square on portrait
                let posX = (height - width) / 2
                return CGRect(x: posX, y: 0, width: height, height: height)
            }
        }
    }
}
