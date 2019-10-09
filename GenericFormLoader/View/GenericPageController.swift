//
//  GenericPageController.swift
//  GenericFormLoader
//
//  Created by TECHIES on 10/9/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit

class GenericPageController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var counted:Int = 0
    
    let pages = [
        Page(imageName: "icon_splash_one", headerText: "Create or Join Trip Group", bodyText: "Create cool and stress free trip groups for you and your freinds and family"),
        Page(imageName: "icon_splash_two", headerText: "Get a Driver and Vehicle", bodyText: "Get a professional driver once your new trip group is filled up"),
        Page(imageName: "icon_splash_three", headerText: "Enjoy Your Trip", bodyText: "Ride in Comfort, Securely and Conveniently to your preferred Destination.")
    ]
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .blue
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        let pageNumber = Int(x / view.frame.width)
        
        if pageNumber == 2{
            customImageView.isHidden = true
            continueLabel.isHidden = false
            skipAllLabel.isHidden = true
        }else{
            customImageView.isHidden = false
            continueLabel.isHidden = true
            skipAllLabel.isHidden = false
        }
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    let skipAllLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .blue
        label.text = "Skip all"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()
    
    lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_right_arrow")
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let continueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Continue"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()
    
    @objc func handleSkipAll() {
//        let vc = LoginController()
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControls()
        collectionView?.backgroundColor = .white
        collectionView?.register(GenericPageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        
        customImageView.isHidden = false
        continueLabel.isHidden = true
        skipAllLabel.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    let stackView = UIStackView()
    fileprivate func setupBottomControls() {
        view.addSubview(skipAllLabel)
        view.addSubview(pageControl)
        view.addSubview(customImageView)
        view.addSubview(continueLabel)
        
        pageControl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        view.addConstraint(NSLayoutConstraint(item: skipAllLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -50))
        view.addConstraint(NSLayoutConstraint(item: skipAllLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 20))
        
        view.addConstraint(NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -80))
        view.addConstraint(NSLayoutConstraint(item: pageControl, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: customImageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -45))
        view.addConstraint(NSLayoutConstraint(item: customImageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -50))
        
        view.addConstraint(NSLayoutConstraint(item: continueLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -50))
        view.addConstraint(NSLayoutConstraint(item: continueLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -50))
        
        skipAllLabel.isUserInteractionEnabled = true
        skipAllLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSkipAll)))
        
        customImageView.isUserInteractionEnabled = true
        customImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNextPageClick)))
        
        continueLabel.isUserInteractionEnabled = true
        continueLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSkipAll)))
    }
    
    @objc func onNextPageClick(){
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        let pageNumber = currentItem.item + 1
        print("ITEMNUMBER ==> \(pageNumber)")
        if nextItem.row < pages.count {
            if pageNumber == 2{
                customImageView.isHidden = true
                continueLabel.isHidden = false
                skipAllLabel.isHidden = true
            }
            pageControl.currentPage = pageNumber
            self.collectionView.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
//            selectedExerciseData = items[nextItem.item].exercise
//            initExerciseData()
        }
    }
    
    func initViews(){
        
    }
    
}
