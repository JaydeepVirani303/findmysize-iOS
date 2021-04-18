//
//  StomachVC.swift
//  Femi9Tracking
//
//  Created by Piyush on 13/04/21.
//

import UIKit

class StomachVC: UIViewController {
    
    @IBOutlet weak var btnFlatter: UIButton!
    @IBOutlet weak var btnAvarage: UIButton!
    @IBOutlet weak var btnRounder: UIButton!
    @IBOutlet weak var imgUser: UIImageView!
    
    var selectedIndex:Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if appDelegate.selectedStomachIndex != nil {
            self.selectedIndex = appDelegate.selectedStomachIndex!
        }
        self.changeColor(index: self.selectedIndex)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnContinueClicked(_ sender: Any) {
        appDelegate.belly = 10
        if #available(iOS 13.0, *) {
            let obj = self.storyboard?.instantiateViewController(identifier: "HipsVC") as! HipsVC
            self.navigationController?.pushViewController(obj, animated: false)
        } else {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "HipsVC") as! HipsVC
            self.navigationController?.pushViewController(obj, animated: false)
        }
    }
    
    @IBAction func btnCloseAction(_ sender:UIButton) {
        self.dismissVC()
    }
    
    @IBAction func btnFlatterAction(_ sender:UIButton) {
        self.changeColor(index: 0)
    }
    
    @IBAction func btnAvarageAction(_ sender:UIButton) {
        self.changeColor(index: 1)
    }
    
    @IBAction func btnRounderAction(_ sender:UIButton) {
        self.changeColor(index: 2)
    }
    
    func changeColor(index: Int) {
        appDelegate.selectedStomachIndex = index
        self.btnFlatter.setTitleColor(.lightGray, for: .normal)
        self.btnAvarage.setTitleColor(.lightGray, for: .normal)
        self.btnRounder.setTitleColor(.lightGray, for: .normal)
        self.btnFlatter.removeUnderline()
        self.btnAvarage.removeUnderline()
        self.btnRounder.removeUnderline()
        if index == 0 {
            self.imgUser.image = UIImage(named: "stomach_flatter")
            self.btnFlatter.underline()
            self.btnFlatter.setTitleColor(.black, for: .normal)
        }
        else if index == 1 {
            self.btnAvarage.underline()
            self.imgUser.image = UIImage(named: "stomach_average")
            self.btnAvarage.setTitleColor(.black, for: .normal)
        }
        else {
            self.imgUser.image = UIImage(named: "stomach_rounder")
            self.btnRounder.underline()
            self.btnRounder.setTitleColor(.black, for: .normal)
        }
    }
}

extension UIButton {
    func underline() {
        if let textUnwrapped = self.titleLabel?.text {
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
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
