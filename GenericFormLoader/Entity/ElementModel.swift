//
//  ElementModel.swift
//  GenericFormLoader
//
//  Created by TECHIES on 10/9/19.
//  Copyright © 2019 Techies. All rights reserved.
//

import Foundation
class ElementModel : NSObject, NSCoding{

    var isMandatory : Bool!
    var label : String!
    var rules : [AnyObject]!
    var type : String!
    var file : String!
    var uniqueId : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        isMandatory = dictionary["isMandatory"] as? Bool
        label = dictionary["label"] as? String
        type = dictionary["type"] as? String
        uniqueId = dictionary["unique_id"] as? String
        file = dictionary["file"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if isMandatory != nil{
            dictionary["isMandatory"] = isMandatory
        }
        if label != nil{
            dictionary["label"] = label
        }
        if type != nil{
            dictionary["type"] = type
        }
        if uniqueId != nil{
            dictionary["unique_id"] = uniqueId
        }
        if file != nil{
            dictionary["file"] = file
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        isMandatory = aDecoder.decodeObject(forKey: "isMandatory") as? Bool
        label = aDecoder.decodeObject(forKey: "label") as? String
        rules = aDecoder.decodeObject(forKey: "rules") as? [AnyObject]
        type = aDecoder.decodeObject(forKey: "type") as? String
        uniqueId = aDecoder.decodeObject(forKey: "unique_id") as? String
        file = aDecoder.decodeObject(forKey: "file") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if isMandatory != nil{
            aCoder.encode(isMandatory, forKey: "isMandatory")
        }
        if label != nil{
            aCoder.encode(label, forKey: "label")
        }
        if rules != nil{
            aCoder.encode(rules, forKey: "rules")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if uniqueId != nil{
            aCoder.encode(uniqueId, forKey: "unique_id")
        }
        if file != nil{
            aCoder.encode(file, forKey: "file")
        }
    }
}
