//
//  SoundMapItems.swift
//  Lost in Doi Saket
//
//  Created by Sacha Schwab on 05.10.15.
//  Copyright © 2015 Sacha Schwab. All rights reserved.
//

import Foundation

struct SoundMapItem {
    var id : Int = 0
    var title = ""
    var tag_list = ""
    var artwork_url = ""
    var description = ""
    var genre = ""
    var last_modified = ""
    var permalink = ""
    var attachments_uri = ""
    
    // Construct a soundmap object from a dictionary
    init(dictionary: [String : AnyObject]) {
        
        id = dictionary["id"] as! Int
        title = dictionary["title"] as! String
        tag_list = dictionary["tag_list"] as! String
        artwork_url = dictionary["artwork_url"] as! String
        description = dictionary["description"] as! String
        genre = dictionary ["genre"] as! String
        last_modified = dictionary["last_modified"] as! String
        attachments_uri = dictionary["attachments_uri"] as! String
        permalink = dictionary["permalink"] as! String
    }
    
    static func soundMapItemsFromResults(results: [[String : AnyObject]]) -> [SoundMapItem] {
        
        var soundMapItems = [SoundMapItem]()
        
        // Iterate through array of dictionaries; each studentItem is a dictionary
        for result in results {
            soundMapItems.append(SoundMapItem(dictionary: result))
        }
        return soundMapItems
    }
}