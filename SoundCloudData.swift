//
//  SoundCloudData.swift
//  Lost in Doi Saket
//
//  Created by Sacha Schwab on 09.10.15.
//  Copyright © 2015 Sacha Schwab. All rights reserved.
//

import UIKit
import MapKit

class SoundCloudData {
    
    let clientID = Constants.Constants().clientID
    
    var soundMapItems: [SoundMapItem] = [SoundMapItem]()
    var annotations: [(MKPointAnnotation)]?
    
    // MARK: Get Data
    
    func getSoundCloudData(controller: UIViewController, completionHandler: (annotations: [(MKPointAnnotation)], soundMapItems: [SoundMapItem],success: Bool) -> Void)  {
        
        // Initialize session and url
        let session = NSURLSession.sharedSession()
        let urlString = "https://api.soundcloud.com/playlists/12281864?client_id=\(clientID)"
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        // Initialize task for getting data
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            // Check for a successful response
            // GUARD: Was there an error?
            
            guard (error == nil) else {

                if error?.domain == NSURLErrorDomain {
                    error?.userInfo.description
                    print("error domain detected: \(error?.debugDescription)")
                    AlertView().showAlertViewCenter("Network error", messageText: "The Internet connection appears to be offline", cancelContinueOption: false, segue: nil, controller: controller)
                } else {
                    AlertView().showAlertViewCenter("Error", messageText: "Data could not be downloaded. Please try again later.  System error message: '\(error?.debugDescription)'", cancelContinueOption: false, segue: nil, controller: controller)
                }

                return
            }
            
            // GUARD: Was there any data returned?
            guard let data = data else {
                dispatch_async(dispatch_get_main_queue(), {
                    // set something
                })
                
                AlertView().showAlertViewCenter("Data download error", messageText: "Sorry, no data was returned to the app. Please try again later", cancelContinueOption: false, segue: nil, controller: controller)
                return
            }
            
            // Parse the data (i.e. convert the data to JSON and look for values!)
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch {
                parsedResult = nil
                dispatch_async(dispatch_get_main_queue(), {
                    // set something
                })

                AlertView().showAlertViewCenter("Data download error", messageText: "Sorry, app is not able to use the downloaded data - please try again later", cancelContinueOption: false, segue: nil, controller: controller)
                return
            }
            
            // Is there a tracks list?
            guard let tracksArray = parsedResult["tracks"] as? NSArray else {
                dispatch_async(dispatch_get_main_queue(), {
                    // set something
                })
                
                return
            }
            
            self.soundMapItems = SoundMapItem.soundMapItemsFromResults(tracksArray as! [[String : AnyObject]])
            
            // // NEXT VERSION: Consider aligning tags with this
            for (_, _) in self.soundMapItems.enumerate() {
                // change a value
            }
            
            self.annotations = Annotations().getSoundMapLocations(self.soundMapItems)

            print("Number of annotations created: \(self.annotations?.count)")
            
            completionHandler(annotations: self.annotations!, soundMapItems: self.soundMapItems, success: true)
        }
        
        task.resume()
    }

    func separateTitleData(fullTitle: String) -> (englishTitle: String, thaiTitle: String) {
        // set title and subtitle for annotation
        var titleArray = []
        var englishTitle = ""
        var thaiTitle = ""
        
        let separator = NSCharacterSet(charactersInString: "/")
        let slashRange = fullTitle.rangeOfCharacterFromSet(separator)
        if slashRange != nil {
            titleArray = fullTitle.componentsSeparatedByCharactersInSet(separator)
            englishTitle = titleArray[0] as! String
            thaiTitle = titleArray[1] as! String
        } else {
            englishTitle = fullTitle
            thaiTitle = fullTitle
        }
        
        return (englishTitle, thaiTitle)
    }
}
