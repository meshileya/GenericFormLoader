//
//  GenericPageCell.swift
//  GenericFormLoader
//
//  Created by TECHIES on 10/9/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit

class GenericPageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            
            ellipseImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
            
            textHeaderandDescription.attributedText = attributedText
            textHeaderandDescription.textAlignment = .center
            textHeaderandDescription.backgroundColor = .white
            
            print("TheImageName ==> \(unwrappedPage.imageName)")
        }
    }
    // Generated Swift code for Vector
    
    
    //    let headerImageView: UIImageView = {
    //        let imageView = UIImageView()
    //        imageView.image = UIImage(named: "header_one")
    //        imageView.contentMode = .scaleAspectFill
    //        imageView.layer.masksToBounds = true
    //        return imageView
    //    }()
    
    let ellipseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_ellipse")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let textHeaderandDescription: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Ride!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        
        attributedText.append(NSAttributedString(string: "\n\n\n Ride", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.blue]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    //    let textTitleDescription: UILabel = {
    //        let label = UILabel()
    //        label.font = UIFont(name: "Heiti TC", size: 13)
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        label.textColor = UIColor.lightGray
    //        label.text = "Your description"
    //        label.numberOfLines = 2
    //        return label
    //    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        
        //        addSubview(headerImageView)
        addSubview(ellipseImageView)
        addSubview(textHeaderandDescription)
        //        addSubview(textTitleDescription)
        
        
        //        addConstraintsWithFormat("H:|[v0]|", views: headerImageView)
        //        addConstraintsWithFormat("V:|[v0(110)]|", views: headerImageView)
        //        addConstraintsWithFormat("H:|[v0(170)]|", views: ellipseImageView)
        //        addConstraintsWithFormat("V:|[v0(170)]|", views: headerImageView)
        //top constraintc
        addConstraint(NSLayoutConstraint(item: ellipseImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 100))
        //right constraint
        addConstraint(NSLayoutConstraint(item: ellipseImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        //        addConstraint(NSLayoutConstraint(item: ellipseImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: ellipseImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: self.frame.height/2 - 50))
        //left constraint
        //        addConstraint(NSLayoutConstraint(item: ellipseImageView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 170))
        
        //top constraintc
        addConstraint(NSLayoutConstraint(item: textHeaderandDescription, attribute: .top, relatedBy: .equal, toItem: ellipseImageView, attribute: .bottom, multiplier: 1, constant: 40))
        //right constraint
        addConstraint(NSLayoutConstraint(item: textHeaderandDescription, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10))
        //height constraint
        addConstraint(NSLayoutConstraint(item: textHeaderandDescription, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 170))
        //left constraint
        addConstraint(NSLayoutConstraint(item: textHeaderandDescription, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
