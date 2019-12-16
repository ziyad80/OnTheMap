//
//  MessagInfoAlert.swift
//  OnTheMap
//
//  Created by Ziyad Alsaeed on 12/17/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import Foundation
import UIKit

class MessagInfoAlert: UIViewController {
class func showAlert(title: String, message: String){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let OKAction = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(OKAction)
    
    var alertWindow : UIWindow!
    alertWindow = UIWindow.init(frame: UIScreen.main.bounds)
    alertWindow.rootViewController = UIViewController.init()
    alertWindow.windowLevel = UIWindow.Level.alert + 1
    alertWindow.makeKeyAndVisible()
    alertWindow.rootViewController?.present(alertController, animated: true)
}
}
