//
//  PrivacyPolicyVC.swift
//  Femi9Tracking
//
//  Created by Piyush on 13/04/21.
//

import UIKit

class PrivacyPolicyVC: UIViewController {
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
  
    @IBAction func btnCloseAction(_ sender:UIButton) {
        self.dismissVC()
    }
}
