//
//  EventModel.swift
//  Eventmanage
//
//  Created by Jenish on 25/06/19.
//  Copyright © 2019 Jenish. All rights reserved.
//

import Foundation

class EventModel: NSObject {
    
    var eventname: String!
    var image:String!
    var datetime:String!
    var place: String!
    var like: String!
    var id:Int!
    
    override init() {
        
    }
    
    init(attrDict:NSDictionary) {
        
        eventname = ""
        image = ""
        place  = ""
        datetime = ""
        like = ""
        id = 0
        
        if let val = attrDict.value(forKey: "id") as? Int {
            self.id = val
        }
        
        if let val = attrDict.value(forKey: "title") as? String {
            self.eventname = "\(val)"
        }
        
        if let val = attrDict.value(forKey: "performers") as? NSArray {
            
            for images in val{
                
                let image = images as! NSDictionary
                
                if let image_attributes = image.value(forKey: "image") as? String{
                    
                    self.image = image_attributes
                }
                
            }
            
            //self.image = "\(val)"
        }
        if let val = attrDict.value(forKey: "venue") as? NSDictionary {
            if let displayplace = val.value(forKey: "display_location") as? String{
                self.place = "\(displayplace)"
                
            }
            
        }
        if let val = attrDict.value(forKey: "datetime_utc") as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date22 = dateFormatter.date(from: val)
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "E, d MMM yyyy h:mm a"
            
            let date33 = dateFormatterPrint.string(from: date22!)
            
            self.datetime = "\(date33)"
        }
        if let val = attrDict.value(forKey: "like") as? String {
            self.like = "\(val)"
        }
        
    }
}
