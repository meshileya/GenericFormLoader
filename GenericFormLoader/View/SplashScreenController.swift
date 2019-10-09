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
        view.addSubview(customImageView)
        view.addSubview(welcomeInfoLabel)
        
        view.addConstraint(NSLayoutConstraint(item: customImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: customImageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: welcomeInfoLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 50))
        view.addConstraint(NSLayoutConstraint(item: welcomeInfoLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -50))
        view.addConstraint(NSLayoutConstraint(item: welcomeInfoLabel, attribute: .top, relatedBy: .equal, toItem: customImageView, attribute: .bottom, multiplier: 1, constant: 10))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let swipingController = GenericPageController(collectionViewLayout: layout)
        self.navigate(controller: swipingController, animate: 3)
    }
    
    let welcomeLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.text = "Welcome to"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.sizeToFit()
        return label
    }()
    
    lazy var  headerImageView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 175).isActive = true
        view.heightAnchor.constraint(equalToConstant: 35).isActive = true
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.addSubview(customImageView)
        
        customImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        customImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }()
    
    lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_splashscreen")
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 270).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let welcomeInfoLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        label.text = "Start booking Daily Sheefts"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
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
