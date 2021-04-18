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
//let mainStoryboard = UIStoryboard(name: "Femi9", bundle: bundle)
let mainStoryboard = UIStoryboard(name: "Femi9",
    bundle: Bundle(identifier: "org.cocoapods.findmysize"))
var Measurement_key = "Measurement_key"
var Size_notification_key = "Size_notification_key"
let colorGray = UIColor(red: 96/255, green: 106/255, blue: 113/255, alpha: 1)

//let appDelegate = UIApplication.shared.delegate as! AppDelegate

var apiKey: String = "8MYHPT4-6364FZJ-Q2SW96P-GEBF9QP"
var kUserId: String = ""
var height: Int = 0
var weight: Int = 0
var age: Int = 0
var belly: Int = 0
var hip: Int = 0
var brand: Int = 0
var brandSize: Int = 0

var isFT: Bool = false
var heightIndex: Int?

var isLBS: Bool = false
var widthIndex: Int?

var selectedAgeIndex: Int?
var selectedStomachIndex: Int?
var selectedHipsIndex: Int?

func resetData() {
    isFT = false
    heightIndex = nil
    
    isLBS = false
    widthIndex = nil
    
    selectedAgeIndex = nil
    selectedStomachIndex = nil
    selectedHipsIndex = nil
}

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

final class FindMySizeSDK {
    static let resourceBundle: Bundle = {
        let myBundle = Bundle(for: FindMySizeSDK.self)

        guard let resourceBundleURL = myBundle.url(
            forResource: "Femi9", withExtension: "storyboard")
            else { fatalError("MySDK.bundle not found!") }

        guard let resourceBundle = Bundle(url: resourceBundleURL)
            else { fatalError("Cannot access MySDK.bundle!") }

        return resourceBundle
    }()
}


