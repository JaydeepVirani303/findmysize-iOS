//
//  HipsVC.swift
//  Femi9Tracking
//
//  Created by Piyush on 13/04/21.
//

import UIKit
import SwiftyJSON

class HipsVC: UIViewController {
    
    @IBOutlet weak var btnNarrower: UIButton!
    @IBOutlet weak var btnAverage: UIButton!
    @IBOutlet weak var btnCurvier: UIButton!
    
    @IBOutlet weak var imgUser: UIImageView!
    
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorView.Style.gray)
    var selectedIndex:Int = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedHipsIndex != nil {
            self.selectedIndex = selectedHipsIndex!
        }
        self.changeColor(index: self.selectedIndex)
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.bringSubview(toFront:view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        indicator.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnContinueClicked(_ sender: Any) {
        hip = 10
        self.getSize()
    }
    
    @IBAction func btnCloseAction(_ sender:UIButton) {
        self.dismissVC()
    }
    
    @IBAction func btnNarrowerAction(_ sender:UIButton) {
        self.changeColor(index: 0)
    }
    
    @IBAction func btnAverageAction(_ sender:UIButton) {
        self.changeColor(index: 1)
    }
    
    @IBAction func btnCurvierAction(_ sender:UIButton) {
        self.changeColor(index: 2)
    }
    
    func changeColor(index: Int) {
        selectedHipsIndex = index
        self.btnNarrower.setTitleColor(.lightGray, for: .normal)
        self.btnAverage.setTitleColor(.lightGray, for: .normal)
        self.btnCurvier.setTitleColor(.lightGray, for: .normal)
        
        self.btnNarrower.removeUnderline()
        self.btnAverage.removeUnderline()
        self.btnCurvier.removeUnderline()
        
        if index == 0 {
            self.imgUser.image = UIImage(named: "hips_narrower")
            self.btnNarrower.underline()
            self.btnNarrower.setTitleColor(.black, for: .normal)
        }
        else if index == 1 {
            self.btnAverage.underline()
            self.imgUser.image = UIImage(named: "hips_average")
            self.btnAverage.setTitleColor(.black, for: .normal)
        }
        else {
            self.imgUser.image = UIImage(named: "hips_curvier")
            self.btnCurvier.underline()
            self.btnCurvier.setTitleColor(.black, for: .normal)
        }
    }
    
    func showProgress() {
        indicator.isHidden = false
        self.indicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func hideProgress() {
        self.indicator.stopAnimating()
        indicator.isHidden = true
        self.view.isUserInteractionEnabled = true
    }
    
    func getSize() {
        let dict = ["apiKey": apiKey,
                    "userId": userId,
                    "height": height,
                    "weight": weight,
                    "age": age,
                    "belly": belly,
                    "hip": hip,
                    "brand": brand,
                    "brandSize": brandSize] as [String : Any]
        print(dict)
        self.showProgress()
        
        ApiManager.shared.MakePostAPI(name: "https://sizeitapi.miqyas.net/api/v1/measurements", params: dict, vc: self) { [self] (response, error) in
            self.hideProgress()
            if response != nil {
                let json = JSON(response!)
                print(json)
                saveJSON(j: json, key: Measurement_key)
                print(loadJSON(key: Measurement_key))
                //                showAlert(message: "Record saved successfully", vc: self)
//                self.dismiss(animated: true) {
//                }
                NotificationCenter.default.post(name: Notification.Name(Size_notification_key), object: nil)
                resetData()
            }
            else {
                showAlert(message: "Record not found", vc: self)
            }
        }
    }
}

//{
//"apiKey": "8MYHPT4-6364FZJ-Q2SW96P-GEBF9QP",
//"userId": 12345,
//"height": 160,
//"weight": 60,
//"age": 24,
//"belly": 10,
//"hip": 10,
//"brand": "",
//"brandSize": 10
//}
//use this key: 8MYHPT4-6364FZJ-Q2SW96P-GEBF9QP
//
//https://sizeitapi.miqyas.net/api/v1/measurements
