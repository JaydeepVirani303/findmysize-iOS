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
let mainStoryboard = UIStoryboard(name: "Femi9", bundle: Bundle(identifier: "org.cocoapods.findmysize"))
var Measurement_key = "Measurement_key"
var Size_notification_key = "Size_notification_key"
let colorGray = UIColor(red: 96/255, green: 106/255, blue: 113/255, alpha: 1)


var apiKey: String = "8MYHPT4-6364FZJ-Q2SW96P-GEBF9QP"
var kUserId: String = ""
var kHeight: Int = 0
var kWeight: Int = 0
var kAge: Int = 0
var kBelly: Int = 0
var kHip: Int = 0
var kBrand: Int = 0
var kBrandSize: Int = 0

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

extension UIButton {
    func underline() {
        if let textUnwrapped = self.titleLabel?.text {
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
            let underlineAttributedString = NSAttributedString(string: textUnwrapped, attributes: underlineAttribute)
            self.setAttributedTitle(underlineAttributedString, for: .normal)
        }
    }
    
    func removeUnderline() {
        if let textUnwrapped = self.titleLabel?.text {
            let underlineAttributedString = NSAttributedString(string: textUnwrapped, attributes: nil)
            self.setAttributedTitle(underlineAttributedString, for: .normal)
        }
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}

extension UIViewController: UIGestureRecognizerDelegate {
    @objc func dismissVC(){
        self.dismiss(animated: true, completion: nil)
    }
}
