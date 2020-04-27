//
//  ViewController.swift
//  SBHelpers
//
//  Created by Balashov152 on 01/13/2020.
//  Copyright (c) 2020 Balashov152. All rights reserved.
//

import UIKit
import SBHelpers

class ViewController: UIViewController {

    func checkArrayEx() {
        _ = [1, 2, 3].contains(oneOfCollection: [1, 2]) // return true
        _ = [1, 2, 3].contains(oneOfCollection: [7, 9]) // return false
        
        _ = [1, 2, 3][safe: 0] // return 1
        _ = [1, 2, 3][safe: 7] // return nil, without crash
        
        _ = [1, 2, 3].unique // return [1, 2, 3]
        _ = [3, 3, 3].unique // return [3]
    }
    
    func checkDateFormatterEx() {
        _ = DateFormatter(format: "HH-mm-yyyy") // create with format
    }
    
    func checkDiffIterative() {
        let result = DiffIterative.diffIterative([1, 2, 3], [3, 4, 5], with: { $0 == $1 })
        _ = result.inserted
        _ = result.common
        _ = result.removed
        
        // DiffIterative for search common and differentive elements
    }
    
    func checkDoubleEx() {
        _ = 0.1234567.rounded(toPlaces: 2) // return 0.12
    }
    
    func checkNSAttributedStringEx() {
        _ = NSAttributedString.strike(value: "12345") // return strike 12345
        _ = NSAttributedString.iconImage(UIImage(), titleFont: .systemFont(ofSize: 14)) // return image string
    }
    
    func checkStringEx() {
        _ = "hello".capitalizingFirstLetter() // return Hello
        _ = "hello".size(font: .systemFont(ofSize: 14),
                         constrainedToWidth: UIScreen.main.bounds.width)
        // return size for hello
    }
    
    func checkRange() {
        _ = range(min: 100, element: 50, max: 200) // return 100
        _ = range(min: 100, element: 250, max: 200) // return 200
    }
    
    func checkSynchronization() {
        var collection = [1, 2, 3]
        Synchronization.sync(item: 1, inCollection: &collection, limit: 0)
        // if limit == 0, that unlimit add, without dublicate
        // if limit > 0, that limit add, without dublicate
        // if limit == 1, that collection contains only 1 element.self
    }
    
    func checkNib() {
        _ = UIViewController.loadFromNib() // load controller from nib, search Nib file for class name
        _ = NibView() // use for parent class, in owner class for NibView
    }
    
    // MARK: UI Folder
    
    func checkUIApplicationEx() {
        // work before iOS 13.0
        _ = UIApplication.shared.statusBarView // return statusBarView
        UIApplication.shared.changeStatusBar(alpha: 0.5)
        UIApplication.shared.hideStatusBar()
        UIApplication.shared.showStatusBar()
        
        _ = UIApplication.topViewController // return topViewController from screen
    }
    
    func checkUICollectionViewEx() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        _ = UIApplication.shared.statusBarView // return statusBarView
        UIApplication.shared.changeStatusBar(alpha: 0.5)
        UIApplication.shared.hideStatusBar()
        UIApplication.shared.showStatusBar()
        
        _ = collectionView.contentWidth
        _ = collectionView.contentHeight
        
        _ = collectionView.widthForItem(sectionInsets: .zero, numberOfColumns: 2, interItemSpacing: 20)
        
        collectionView.register(nib: UICollectionViewCell.self)
        collectionView.register(cell: UICollectionViewCell.self)
        
        let _ : UICollectionViewCell = collectionView.dequeueReusableCell(for: IndexPath(item: 0, section: 0))
        
        let _ : UICollectionViewCell = collectionView.dequeueReusableCell(for: 7)
    }

}

