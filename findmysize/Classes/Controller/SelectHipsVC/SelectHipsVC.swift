//
//  SelectHipsVC.swift
//  Femi9Tracking
//
//  Created by Piyush on 13/04/21.
//

import UIKit
import SwiftyJSON

class SelectHipsVC: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var btnNarrower: UIButton!
    @IBOutlet weak var btnAverage: UIButton!
    @IBOutlet weak var btnCurvier: UIButton!    
    @IBOutlet weak var imgHips: UIImageView!
    
    //MARK: - Variables
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorView.Style.gray)
    var selectedIndex:Int = 2
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedHipsIndex != nil {
            self.selectedIndex = selectedHipsIndex!
        }
        
        //Chanage hips default selection
        self.changeHips(index: self.selectedIndex)
        
        //Showing indicator
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.bringSubview(toFront:view)
        indicator.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    //Chanage Hips selection
    func changeHips(index: Int) {
        selectedHipsIndex = index
        self.btnNarrower.setTitleColor(.lightGray, for: .normal)
        self.btnAverage.setTitleColor(.lightGray, for: .normal)
        self.btnCurvier.setTitleColor(.lightGray, for: .normal)
        
        self.btnNarrower.removeUnderline()
        self.btnAverage.removeUnderline()
        self.btnCurvier.removeUnderline()
        
        if index == 0 {
            self.imgHips.image = UIImage(named: "hips_narrower", in: Bundle(identifier: "org.cocoapods.findmysize"), compatibleWith: nil)
            self.btnNarrower.underline()
            self.btnNarrower.setTitleColor(.black, for: .normal)
        }
        else if index == 1 {
            self.btnAverage.underline()
            self.imgHips.image = UIImage(named: "hips_average", in: Bundle(identifier: "org.cocoapods.findmysize"), compatibleWith: nil)
            self.btnAverage.setTitleColor(.black, for: .normal)
        }
        else {
            self.imgHips.image = UIImage(named: "hips_curvier", in: Bundle(identifier: "org.cocoapods.findmysize"), compatibleWith: nil)
            self.btnCurvier.underline()
            self.btnCurvier.setTitleColor(.black, for: .normal)
        }
    }
    
    //Show and hide progress
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
    
    //Get and save size in local
    func getSize() {
        let dict = ["apiKey": apiKey,
                    "userId": kUserId,
                    "height": kHeight,
                    "weight": kWeight,
                    "age": kAge,
                    "belly": kBelly,
                    "hip": kHip,
                    "brand": kBrand,
                    "brandSize": kBrandSize] as [String : Any]
        self.showProgress()
        ApiManager.shared.MakePostAPI(name: "https://sizeitapi.miqyas.net/api/v1/measurements", params: dict, vc: self) { [self] (response, error) in
            self.hideProgress()
            if response != nil {
                let json = JSON(response!)
                saveJSON(j: json, key: Measurement_key)
                NotificationCenter.default.post(name: Notification.Name(Size_notification_key), object: nil)
                resetData()
            }
            else {
                showAlert(message: "Record not found", vc: self)
            }
        }
    }
    
    //MARK: - @IBAction
    
    //Back previous screen
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    //Get size from server
    @IBAction func btnContinueClicked(_ sender: Any) {
        kHip = 10
        self.getSize()
    }
    
    //Close screen
    @IBAction func btnCloseAction(_ sender:UIButton) {
        self.dismissVC()
    }
    
    //Change Hips selection
    @IBAction func btnNarrowerAction(_ sender:UIButton) {
        self.changeHips(index: 0)
    }
    
    @IBAction func btnAverageAction(_ sender:UIButton) {
        self.changeHips(index: 1)
    }
    
    @IBAction func btnCurvierAction(_ sender:UIButton) {
        self.changeHips(index: 2)
    }
}
