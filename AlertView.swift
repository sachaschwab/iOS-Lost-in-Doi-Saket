//
//  AlertView.swift
//  On the Map
//
//  Created by Sacha Schwab on 11.08.15.
//  Copyright (c) 2015 Sacha Schwab. All rights reserved.
//

import UIKit

class AlertView: NSObject {
    
    /* func showAlertViewBottom(errorText: String, controller: UIViewController) {
        
        var arrowImageView = UIImageView(frame: CGRectMake(0, 50, controller.view.frame.width, 200))
        var image = UIImage(named: "down-arrow.png")
        arrowImageView.image = image
        controller.view.addSubview(arrowImageView)
        UIView.animateWithDuration(1, animations: {
            arrowImageView.center.y += controller.view.bounds.height
            
        })
        
        // Handle alert view and dismiss the controller after the user clicks "ok"
        let alertController = UIAlertController()
        alertController.title = errorText
        alertController.message = ""
        let okAction = UIAlertAction (title:"ok", style: UIAlertActionStyle.Default) {
            action in alertController.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(okAction)
        controller.presentViewController(alertController, animated: true, completion:nil)
    } */
    
    func showAlertViewCenter(titleText: String, messageText: String, cancelContinueOption: Bool, segue: String?, controller: UIViewController) {
        
        // set up alert controller
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertControllerStyle.Alert)
        
        if cancelContinueOption {
            
            alertController.addAction(UIAlertAction(title: "Continue", style: .Default, handler: { (action: UIAlertAction!) in
                controller.performSegueWithIdentifier("somesegue", sender: controller)
            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                
            }))
            
            
        } else {
            // Handle alert view and dismiss the controller after the user clicks "ok"
            let okAction = UIAlertAction (title:"ok", style: UIAlertActionStyle.Default) {
                action in alertController.dismissViewControllerAnimated(true, completion: nil)
            }
            alertController.addAction(okAction)
        }
        
        // present alert controller
        controller.presentViewController(alertController, animated: true, completion: nil)
    }
}
