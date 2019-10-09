//
//  GenericPageCell.swift
//  GenericFormLoader
//
//  Created by TECHIES on 10/9/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SkyFloatingLabelTextField

class GenericPageCell: UICollectionViewCell, UIScrollViewDelegate {
    
    let yesLabel = UILabel()
    let noLabel = UILabel()
    let targetLabel = UILabel()
    let dateTimeField = SkyFloatingLabelTextField()
    
    var stackView : UIStackView!
    
    var page: Page? {
        didSet {
            stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = 15
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.alignment = .fill
            
            scrollView.addSubview(stackView)
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 25).isActive = true
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -25).isActive = true
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            
            for sectionItem in page?.sections ?? []{
                let label = UILabel()
                label.text = sectionItem.label
                label.font = .systemFont(ofSize: 14, weight: .bold)
                stackView.addArrangedSubview(label)
                
                for elementItems in sectionItem.elements{
                    
                    
                    if elementItems.type == "embeddedphoto"{
                        let placeholder = "icon_placeholder"
                        
                        let thumbnailImageUrl = elementItems.file ?? placeholder
                        let url = URL(string: thumbnailImageUrl)
                        
                        let imageView = UIImageView()
                        imageView.image = UIImage(named: "icon_placeholder")
                        imageView.translatesAutoresizingMaskIntoConstraints = false
                        imageView.contentMode = .scaleToFill
                        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
                        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
                        
                        imageView.layer.masksToBounds = true
                        imageView.kf.setImage(with: url, placeholder: UIImage(named: placeholder))
                        stackView.addArrangedSubview(imageView)
                        
                    }
                        
                    else if elementItems.type == "text"{
                        let field = SkyFloatingLabelTextField()
                        field.translatesAutoresizingMaskIntoConstraints = false
                        field.keyboardType = .asciiCapable
                        field.title = elementItems.label
                        field.placeholder = elementItems.label
                        field.widthAnchor.constraint(equalToConstant: 300).isActive = true
                        field.tag = 1
                        field.returnKeyType = .next
                        stackView.addArrangedSubview(field)
                    }
                        
                    else if elementItems.type == "formattednumeric"{
                        let field = SkyFloatingLabelTextField()
                        field.translatesAutoresizingMaskIntoConstraints = false
                        field.keyboardType = .numberPad
                        field.title = elementItems.label
                        field.placeholder = elementItems.label
                        field.tag = 1
                        field.returnKeyType = .next
                        stackView.addArrangedSubview(field)
                    }
                    else if elementItems.type == "datetime"{
                        dateTimeField.translatesAutoresizingMaskIntoConstraints = false
                        dateTimeField.keyboardType = .numberPad
                        dateTimeField.title = elementItems.label
                        dateTimeField.placeholder = elementItems.label
                        dateTimeField.tag = 1
                        dateTimeField.returnKeyType = .next
                        dateTimeField.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onDobTapped)))
                        stackView.addArrangedSubview(dateTimeField)
                    }
                        
                    else if elementItems.type == "yesno"{
                        let label = UILabel()
                        label.text = elementItems.label
                        
                        let subStackView = UIStackView()
                        stackView.translatesAutoresizingMaskIntoConstraints = false
                        subStackView.spacing = 15
                        subStackView.axis = .horizontal
                        subStackView.distribution = .fill
                        subStackView.alignment = .fill
                        
                        yesLabel.text = "Yes"
                        yesLabel.textColor = .green
                        yesLabel.font = .systemFont(ofSize: 18, weight: .bold)
                        yesLabel.isUserInteractionEnabled = true
                        yesLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onYesTapped)))
                        
                        
                        noLabel.text = "No"
                        noLabel.textColor = .red
                        noLabel.font = .systemFont(ofSize: 14, weight: .light)
                        noLabel.isUserInteractionEnabled = true
                        noLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onNoTapped)))
                        
                        subStackView.addArrangedSubview(yesLabel)
                        subStackView.addArrangedSubview(noLabel)
                        
                        stackView.addArrangedSubview(label)
                        stackView.addArrangedSubview(subStackView)
                        if elementItems.rules.count > 0{
                            for item in elementItems.rules {
                                for (key, value) in item {
                                    if key as! String == "targets"{
                                        for items in value as! NSArray{
                                            targetLabel.text = (items as! String)
                                            targetLabel.font = .systemFont(ofSize: 14, weight: .bold)
                                            stackView.addArrangedSubview(targetLabel)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    var datePickerContainer = UIView()
    let dobTimePicker = UIDatePicker()
    var dobDatePicker = UIDatePicker()
    
    @objc func onDobTapped(){
        datePickerContainer.frame = CGRect(x: 0.0, y: (self.frame.height/2 + 30), width: self.frame.width, height: 250)
        datePickerContainer.backgroundColor = UIColor.white
        
        let doneButton = UIButton()
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.blue, for: .normal)
        doneButton.addTarget(self, action: #selector(dismissPickupPicker), for: UIControl.Event.touchUpInside)
        doneButton.frame = CGRect(x: 250.0, y: 5.0, width: 70.0, height: 40.0)
        datePickerContainer.addSubview(doneButton)
        
        dobTimePicker.frame = CGRect(x: 0.0, y: 40.0, width: self.frame.width, height: 200.0)
        dobTimePicker.datePickerMode = .dateAndTime
        dobTimePicker.backgroundColor = UIColor.white
        dobTimePicker.addTarget(self, action: #selector(startPickTimeDiveChanged), for: .valueChanged)
        datePickerContainer.addSubview(dobTimePicker)
        
        self.addSubview(datePickerContainer)
    }
    
    @objc func startPickTimeDiveChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        dateTimeField.text = "DOB: \(formatter.string(from: dobDatePicker.date))"
        datePickerContainer.removeFromSuperview()
    }
    
    @objc func dismissPickupPicker() {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        dateTimeField.text = "DOB: \(formatter.string(from: dobDatePicker.date))"
        datePickerContainer.removeFromSuperview()
    }
    
    @objc func onYesTapped(){
        yesLabel.font = .systemFont(ofSize: 18, weight: .bold)
        noLabel.font = .systemFont(ofSize: 14, weight: .light)
        targetLabel.isHidden = false
    }
    
    @objc func onNoTapped(){
        noLabel.font = .systemFont(ofSize: 18, weight: .bold)
        yesLabel.font = .systemFont(ofSize: 14, weight: .light)
        targetLabel.isHidden = true
    }
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.tag = 19200
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 50))
        addConstraint(NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -20))
        addConstraint(NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -50))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
