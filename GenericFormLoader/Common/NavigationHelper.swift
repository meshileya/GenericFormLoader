//
//  NavigationHelper.swift
//  GenericFormLoader
//
//  Created by TECHIES on 10/9/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit

class NavigationHelper {
    
    static func navigationController (_ vc: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc)
        if #available(iOS 11, *){
            navigationController.navigationBar.prefersLargeTitles = false
        }
        navigationController.navigationBar.tintColor = UIColor.orange
        
        return navigationController;
    }
    
    static func transparentNavigationController (_ vc: UIViewController) -> UINavigationController {
        let navController = NavigationHelper.navigationController(vc)
        navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.isTranslucent = true
        return navController
    }
    
    static func performNavigation(_ vc: UIViewController) -> UIViewController {
        let navigationCon = NavigationHelper.navigationController(vc)
        return navigationCon
    }
    
}

class DynamicCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize : CGSize {
        let size = self.contentSize
        return size
    }
}
