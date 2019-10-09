//
//  PageMainResponse.swift
//  GenericFormLoader
//
//  Created by TECHIES on 10/9/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation

class PageMainResponse : NSObject, NSCoding{

    var id : String!
    var name : String!
    var pages : [Page]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? String
        name = dictionary["name"] as? String
        pages = [Page]()
        if let pagesArray = dictionary["pages"] as? [[String:Any]]{
            for dic in pagesArray{
                let value = Page(fromDictionary: dic)
                pages.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if pages != nil{
            var dictionaryElements = [[String:Any]]()
            for pagesElement in pages {
                dictionaryElements.append(pagesElement.toDictionary())
            }
            dictionary["pages"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        pages = aDecoder.decodeObject(forKey: "pages") as? [Page]
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if pages != nil{
            aCoder.encode(pages, forKey: "pages")
        }
    }
}
