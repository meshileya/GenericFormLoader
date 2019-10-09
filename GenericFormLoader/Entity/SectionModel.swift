//
//  SectionModel.swift
//  GenericFormLoader
//
//  Created by TECHIES on 10/9/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation

class SectionModel : NSObject, NSCoding{

    var elements : [ElementModel]!
    var label : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        label = dictionary["label"] as? String
        elements = [ElementModel]()
        if let elementsArray = dictionary["elements"] as? [[String:Any]]{
            for dic in elementsArray{
                let value = ElementModel(fromDictionary: dic)
                elements.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if label != nil{
            dictionary["label"] = label
        }
        if elements != nil{
            var dictionaryElements = [[String:Any]]()
            for elementsElement in elements {
                dictionaryElements.append(elementsElement.toDictionary())
            }
            dictionary["elements"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        elements = aDecoder.decodeObject(forKey: "elements") as? [ElementModel]
        label = aDecoder.decodeObject(forKey: "label") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if elements != nil{
            aCoder.encode(elements, forKey: "elements")
        }
        if label != nil{
            aCoder.encode(label, forKey: "label")
        }
    }
}
