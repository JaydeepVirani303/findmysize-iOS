//
//  FindMySize.swift
//  Femi9Tracking
//
//  Created by Zero thirteen on 11/04/21.
//

import UIKit
import SwiftyJSON

public class FindMySize:UIViewController,FemiTrackingDelegate {
    
    public var handlerUpdate:(String) -> Void = {_ in}
    
    public func hasSizes() -> Bool {
        let json = loadJSON(key: Measurement_key)
        print(json)
        if json.isEmpty {
            return false
        }
        
        return true
    }
    
    public func getSizeByAttribute(userId:String,attributeName:String) -> String {
        let json = loadJSON(key: Measurement_key)
        print(json)
        if json.isEmpty {
            return  ""
        }
        
        let model = MeasurementsModel(JSON: json.dictionaryObject!)
        let filter = model?.data?.sizes?.filter({ (data) -> Bool in
            return data.name == attributeName
        })
        return (filter?.first?.size ?? "")
    }
    
    public func getAllSizes() -> [JSON] {
        let json = loadJSON(key: Measurement_key)
        print(json)
        if json.isEmpty {
            return []
        }
        
        return json["data"]["size"].arrayValue
        
    }
    
    public func openSizePopup(userId:String,attributeName:String,controller:UIViewController) {       
        kUserId = userId
        let obj = mainStoryboard.instantiateViewController(withIdentifier: "SelectHeightVC") as! SelectHeightVC
        obj.delegate = self
        obj.categoryName = attributeName
        let nav = UINavigationController(rootViewController: obj)
        nav.modalTransitionStyle = .coverVertical
        nav.modalPresentationStyle = .currentContext
        controller.present(nav, animated: true, completion: nil)
    }
    
    func FemiTrackingFinish(size: String) {
        print("delegate called Home")
        print(size)
        handlerUpdate(size)
    }
    
}
