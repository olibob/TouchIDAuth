//
//  ViewController.swift
//  Auth
//
//  Created by Olivier Robert on 27/09/14.
//  Copyright (c) 2014 Olivier Robert. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func authenticateButtonTapped(sender: UIButton) {
    let context = LAContext()
    var error = NSError?()    // needs to be an optional because it can be nil
    var alertContoller = UIAlertController()
    
    if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
      // Authenticate User
      context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Are you the device owner", reply: { (success: Bool, error: NSError?) in
        if error != nil {
          alertContoller = self.showAlert("Error", message: "There was a problem verifying your identity")
          self.presentViewController(alertContoller, animated: true, completion: nil)
        }
        
        if success {
          alertContoller = self.showAlert("Success", message: "You are the device owner")
          self.presentViewController(alertContoller, animated: true, completion: nil)
        } else {
          alertContoller = self.showAlert("Failure", message: "You are not the device owner")
          self.presentViewController(alertContoller, animated: true, completion: nil)
        }
      })
      
    } else {
      alertContoller = showAlert("Error", message: "Your device cannot authenticate with TouchID")
      self.presentViewController(alertContoller, animated: true, completion: nil)
    }
  }
  
  func showAlert(title: String, message: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
    alert.addAction(action)
    return alert
  }
}

