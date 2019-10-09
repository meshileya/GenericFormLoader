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
    var pages : [Page] = []
    
    var formDataInteractor = FormInteractor()
    
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
        
        if pageNumber == pages.count - 1{
            customImageView.isHidden = true
            submitLabel.isHidden = false
        }else{
            customImageView.isHidden = false
            submitLabel.isHidden = true
        }
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_custom_arrow")
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let submitLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Submit"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        return label
    }()
    
    @objc func handleSkipAll() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControls()
        collectionView?.backgroundColor = .white
        collectionView?.register(GenericPageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        
        customImageView.isHidden = false
        submitLabel.isHidden = true
        let rDataModel = PageMainResponse(fromDictionary: formDataInteractor.readJsonDataFromFile(fileName: "pet_adoption") as! [String : Any])
        pages = rDataModel.pages
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
    
    fileprivate func setupBottomControls() {
        view.addSubview(pageControl)
        view.addSubview(customImageView)
        view.addSubview(submitLabel)
        
        pageControl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        view.addConstraint(NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -80))
        view.addConstraint(NSLayoutConstraint(item: pageControl, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: customImageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -45))
        view.addConstraint(NSLayoutConstraint(item: customImageView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -50))
        
        view.addConstraint(NSLayoutConstraint(item: submitLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -50))
        view.addConstraint(NSLayoutConstraint(item: submitLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -50))
        
        
        customImageView.isUserInteractionEnabled = true
        customImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNextPageClick)))
        
        submitLabel.isUserInteractionEnabled = true
        submitLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSkipAll)))
    }
    
    @objc func onNextPageClick(){
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        let pageNumber = currentItem.item + 1
        if nextItem.row < pages.count {
            if pageNumber == pages.count - 1{
                customImageView.isHidden = true
                submitLabel.isHidden = false
            }
            pageControl.currentPage = pageNumber
            self.collectionView.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
        }
    }
    
    func initViews(){
        
    }
    
}
