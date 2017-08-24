//
//  DriveGuard.swift
//  DriveGuard
//
//  Created by ben honda on 2017-08-22.
//  Copyright © 2017 honda. All rights reserved.
//

import Foundation
import CoreMotion

public class DriveGuard {
    
    // error message to be displayed if the hardware is insufficient
    let coreMotionErrorMsg = "The activity moniter is not available. DriveGuard requires at least the M7 motion co-processor. It appears this device does not have the hardware needed. For more information please visit the DriveGuard Github page at www.github.com/benhonda/DriveGuard"
    
    // create a CMMotionActivityManager instance
    let coreMotion = CMMotionActivityManager()
    
    
    public init() {}
    
    
    // Function: used to check if the user is driving. Returns a boolean value
    public func userIsDriving(driving: @escaping (_ trueOrFalse: Bool)->()) {
        
        if CMMotionActivityManager.isActivityAvailable() {
            
            coreMotion.startActivityUpdates(to: .main) { (activity) in
                
                if (activity?.automotive)! {
                    
                    driving(true)
                    self.coreMotion.stopActivityUpdates()
                    
                } else {
                    
                    driving(false)
                    
                }
                
            }
            
        } else {
            
            print(coreMotionErrorMsg)
        }
        
    }
    
    
    // Function: displays a UIAlert with custom text
    public func userIsDrivingCustomAlert(viewController: UIViewController, alertTitle: String, alertMessage: String, alertActionTitle: String?, actionNumber: @escaping (Int)->()) {
        
        if CMMotionActivityManager.isActivityAvailable() {
            
            coreMotion.startActivityUpdates(to: .main) { (activity) in
                
                if (activity?.automotive)! {
                    
                    let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
                    
                    let action1 = UIAlertAction(title: "Close", style: .default, handler: { (action) in
                        
                        actionNumber(1)
                    })
                    
                    alert.addAction(action1)
                    
                    if alertActionTitle != "" && alertActionTitle != nil {
                        let action2 = UIAlertAction(title: alertActionTitle, style: .default, handler: { (action) in
                            
                            actionNumber(2)
                        })
                        alert.addAction(action2)
                    }
                    
                    viewController.present(alert, animated: true, completion: nil)
                    
                    self.coreMotion.stopActivityUpdates()
                    
                }
                
            }
            
        } else {
            
            print(coreMotionErrorMsg)
        }
        
    }
    
    
    // Function: displays a UIAlert with generic text
    public func userIsDrivingProhibitedAlert(viewController: UIViewController, actionNumber: @escaping (Int)->()) {
        
        if CMMotionActivityManager.isActivityAvailable() {
            
            coreMotion.startActivityUpdates(to: .main) { (activity) in
                
                if (activity?.automotive)! {
                    
                    let alert = UIAlertController(title: "Hold Up!", message: "Looks like you're in a vehicle. Using our app while driving is prohibited.", preferredStyle: UIAlertControllerStyle.alert)
                    
                    let action1 = UIAlertAction(title: "Close", style: .default, handler: { (action) in
                        
                        actionNumber(1)
                    })
                    
                    let action2 = UIAlertAction(title: "Passenger", style: .default, handler: { (action) in
                        
                        actionNumber(2)
                    })
                    
                    alert.addAction(action1)
                    alert.addAction(action2)
                    
                    viewController.present(alert, animated: true, completion: nil)
                    
                    self.coreMotion.stopActivityUpdates()
                    
                }
                
            }
            
        } else {
            
            print(coreMotionErrorMsg)
        }
        
    }
    
    
    // Function: displays a UIAlert with generic text
    public func userIsDrivingDiscouragedAlert(viewController: UIViewController, completion: (() -> ())? = nil) {
        
        if CMMotionActivityManager.isActivityAvailable() {
            
            coreMotion.startActivityUpdates(to: .main) { (activity) in
                
                if (activity?.automotive)! {
                    
                    let alert = UIAlertController(title: "Hold Up!", message: "Looks like you're in a vehicle. Using our app while driving is unsafe and strongly discouraged.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    viewController.present(alert, animated: true, completion: nil)
                    
                    completion?()
                    
                    self.coreMotion.stopActivityUpdates()
                    
                }
                
            }
            
        } else {
            
            print(coreMotionErrorMsg)
        }
        
    }
    
    
} // DriveGuard class
