//
//  ViewController.swift
//  Femi9Tracking
//
//  Created by Zero thirteen on 11/04/21.
//

import UIKit

class HomeVC: UIViewController, FemiTrackingDelegate {
    
    @IBOutlet weak var btnFind: CustomButton!
    @IBOutlet weak var btnPants: CustomButton!
    @IBOutlet weak var btnSkirts: CustomButton!
    
    var selectedButton: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnFindMyFitAction(_ sender: UIButton) {
        self.selectedButton = 0
        let obj = mainStoryboard.instantiateViewController(withIdentifier: "SelectHeightVC") as! SelectHeightVC
        obj.delegate = self
        let nav = UINavigationController(rootViewController: obj)
        nav.modalTransitionStyle = .coverVertical
        nav.modalPresentationStyle = .currentContext
        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func btnPantsClicked(_ sender: Any) {
        self.selectedButton = 1
        let obj = mainStoryboard.instantiateViewController(withIdentifier: "SelectHeightVC") as! SelectHeightVC
        obj.delegate = self
        obj.categoryName = "Pants-27,28,29,30,31"
        let nav = UINavigationController(rootViewController: obj)
        nav.modalTransitionStyle = .coverVertical
        nav.modalPresentationStyle = .currentContext
        self.present(nav, animated: false, completion: nil)
    }
    
    @IBAction func btnSkirtsClicked(_ sender: Any) {
        self.selectedButton = 2
        let obj = mainStoryboard.instantiateViewController(withIdentifier: "SelectHeightVC") as! SelectHeightVC
        obj.delegate = self
        obj.categoryName = "Skirts-S,M,L,XL,XXL"
        let nav = UINavigationController(rootViewController: obj)
        nav.modalTransitionStyle = .coverVertical
        nav.modalPresentationStyle = .currentContext
        self.present(nav, animated: false, completion: nil)
    }
    
    func FemiTrackingFinish(size: String) {
        print(size)
        if self.selectedButton == 0 {
            
        }
        else if self.selectedButton == 1 {
            self.btnPants.setTitle(size, for: .normal)
        }
        else {
            self.btnSkirts.setTitle(size, for: .normal)
        }
    }
}
