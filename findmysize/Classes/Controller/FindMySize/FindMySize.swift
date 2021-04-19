//
//  FindMySize.swift
//  Femi9Tracking
//
//  Created by Zero thirteen on 11/04/21.
//

import UIKit
import SwiftyJSON

public class FindMySize:UIViewController,FemiTrackingDelegate {
    
    //MARK: - Variables
    //USE : This function return size when selection is complete
    public var handlerUpdate:(String) -> Void = {_ in}
    
    //MARK: - Functions
    //USE : This function return user has selected size erlier or not
    public func hasSizes() -> Bool {
        let json = loadJSON(key: Measurement_key)
        if json.isEmpty {
            return false
        }
        return true
    }
    
    //USE : This function return size if available in passed attribute
    public func getSizeByAttribute(attributeName:String) -> String {
        let json = loadJSON(key: Measurement_key)
        if json.isEmpty {
            return  ""
        }
        
        let model = MeasurementsModel(JSON: json.dictionaryObject!)
        let filter = model?.data?.sizes?.filter({ (data) -> Bool in
            return data.name == attributeName
        })
        return (filter?.first?.size ?? "")
    }
    
    //USE : This function return all size
    public func getAllSizes() -> [JSON] {
        let json = loadJSON(key: Measurement_key)
        if json.isEmpty {
            return []
        }
        return json["data"]["size"].arrayValue
    }
    
    //USE : This function open size picker
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
    
    //USE : This function return selected size
    func FemiTrackingFinish(size: String) {
        handlerUpdate(size)
    }
}
