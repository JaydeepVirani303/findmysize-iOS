//
//  Constant.swift
//  Berry
//
//  Created by Haresh Bhai on 29/10/18.
//  Copyright © 2018 Haresh Bhai. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

//MARK: - Variables
let userDefault = UserDefaults.standard
var Measurement_key = "Measurement_key"
var Size_notification_key = "Size_notification_key"
let colorGray = UIColor(red: 96/255, green: 106/255, blue: 113/255, alpha: 1)
let appDelegate = UIApplication.shared.delegate as! AppDelegate

func isKeyPresentInUserDefaults(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

public func saveJSON(j: JSON, key: String) {
    userDefault.setValue(j.rawString()!, forKey: key)
    // here I save my JSON as a string
}

public func loadJSON(key: String) -> JSON {
    return isKeyPresentInUserDefaults(key: key) ? JSON.init(parseJSON: userDefault.value(forKey: key) as! String) : JSON()
    // JSON from string must be initialized using .parse()
}

public func deleteJSON(key:String) {
    userDefault.removeObject(forKey: key)
}

func showAlert(message: String, vc:UIViewController) {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
}
