//
//  Page.swift
//  GenericFormLoader
//
//  Created by TECHIES on 10/9/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation

class Page : NSObject, NSCoding{

    var label : String!
    var sections : [SectionModel]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        label = dictionary["label"] as? String
        sections = [SectionModel]()
        if let sectionsArray = dictionary["sections"] as? [[String:Any]]{
            for dic in sectionsArray{
                let value = SectionModel(fromDictionary: dic)
                sections.append(value)
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
        if sections != nil{
            var dictionaryElements = [[String:Any]]()
            for sectionsElement in sections {
                dictionaryElements.append(sectionsElement.toDictionary())
            }
            dictionary["sections"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        label = aDecoder.decodeObject(forKey: "label") as? String
        sections = aDecoder.decodeObject(forKey: "sections") as? [SectionModel]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if label != nil{
            aCoder.encode(label, forKey: "label")
        }
        if sections != nil{
            aCoder.encode(sections, forKey: "sections")
        }
    }
}
