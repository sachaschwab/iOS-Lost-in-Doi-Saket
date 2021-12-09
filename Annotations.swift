//
//  Annotations.swift
//  Lost in Doi Saket
//
//  Created by Sacha Schwab on 05.10.15.
//  Copyright © 2015 Sacha Schwab. All rights reserved.
//

import UIKit
import MapKit

class Annotations: NSObject, MKMapViewDelegate {
    
    func getSoundMapLocations(var itemsArray: [SoundMapItem]) -> [(MKPointAnnotation)] {

        // Create an MKPointAnnotation for each dictionary in "locations"
        var annotations = [MKPointAnnotation]()
        
        for (index, dictionary) in itemsArray.enumerate() {
        
            let tag = dictionary.tag_list
            var tagArray = [AnyObject]()
            
            // splitting the coordinate
            let whitespace = NSCharacterSet.whitespaceCharacterSet()
            let range = tag.rangeOfCharacterFromSet(whitespace)
            // range will be nil if no space is found + split
            if range == nil {
                // see whether there is a comma
                let separator = NSCharacterSet(charactersInString: ",")
                let commaRange = tag.rangeOfCharacterFromSet(separator)
                if commaRange != nil {
                    tagArray = tag.componentsSeparatedByCharactersInSet(separator)
                    let annotation = createAnnotation(tagArray, dictionary: dictionary)
                    annotations.append(annotation)
                                    } else {
                    itemsArray.removeAtIndex(index)
                }
            } else {
                tagArray = tag.characters.split{$0 == " "}.map(String.init)
                let annotation = createAnnotation(tagArray, dictionary: dictionary)
                annotations.append(annotation)
            }
        }
        
        return annotations
    }
    
    func createAnnotation(tagArray : NSArray, dictionary : SoundMapItem) -> MKPointAnnotation {
        
        // cast to Double
        let latValue = tagArray[0].doubleValue
        let longValue = tagArray[1].doubleValue
        
        // get lat / long
        let lat = CLLocationDegrees(latValue)
        let long = CLLocationDegrees(longValue)
        
        // create coordinate
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        // create annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate

        // set title and subtitle for annotation
        let fullTitle = dictionary.title
        var titleArray = []
        var englishTitle = ""
        
        // NEXT VERSION: Consider adding thaiTitle variable (= "" in first place)
        
        let separator = NSCharacterSet(charactersInString: "/")
        let slashRange = fullTitle.rangeOfCharacterFromSet(separator)
        if slashRange != nil {
            titleArray = fullTitle.componentsSeparatedByCharactersInSet(separator)
            englishTitle = titleArray[0] as! String
            
            // NEXT VERSION: Consider adding thaiTitle = titleArray[1] as! String
            
        } else {
            englishTitle = dictionary.title
            
            // NEXT VERSION: Consider adding thaiTitle = dictionary.title
        }
        
        annotation.title = englishTitle
        let idString = "\(dictionary.id)"
        annotation.subtitle = "\(idString)"

        return annotation
    }
}

