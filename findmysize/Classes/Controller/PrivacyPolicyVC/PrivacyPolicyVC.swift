//
//  PrivacyPolicyVC.swift
//  Femi9Tracking
//
//  Created by Piyush on 13/04/21.
//

import UIKit

class PrivacyPolicyVC: UIViewController {
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    //MARK:- @IBAction
    //Back previous screen
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
  
    //Close screen
    @IBAction func btnCloseAction(_ sender:UIButton) {
        self.dismissVC()
    }
}
