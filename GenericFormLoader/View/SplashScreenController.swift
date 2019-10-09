//
//  SplashScreenController.swift
//  GenericFormLoader
//
//  Created by TECHIES on 10/9/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit

class SplashScreenController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        initViews()
    }
    
    func initViews(){
        view.addSubview(welcomeInfoLabel)
        
        view.addConstraint(NSLayoutConstraint(item: welcomeInfoLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: welcomeInfoLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -50))
        view.addConstraint(NSLayoutConstraint(item: welcomeInfoLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let swipingController = GenericPageController(collectionViewLayout: layout)
        self.navigate(controller: swipingController, animate: 3)
    }
    
    let welcomeInfoLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.red
        label.text = "Welcome to Generic Form Builder!"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.sizeToFit()
        return label
    }()
    
    func navigate(controller : UIViewController, animate: TimeInterval?) {
        controller.modalPresentationStyle = .fullScreen
        Timer.scheduledTimer(withTimeInterval: animate ?? 1, repeats: false) { (timer) in
            UIApplication.topViewController()?.presentDetail(NavigationHelper.performNavigation(controller))
        }
    }
}
