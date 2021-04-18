//
//  SelectAgeVC.swift
//  Femi9Tracking
//
//  Created by Piyush on 13/04/21.
//

import UIKit

class SelectAgeVC: UIViewController {
    
    //MARK:- Outlet Zone
    @IBOutlet weak var viewAge: UIView!
    @IBOutlet weak var btnAge: UIButton!
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var ageArray: [String] = ["Select age", "14 - 20", "20 - 30", "30 - 40", "40 - 50", "50 - 60", "60+"]
    var ageMiddleArray: [Int] = [0, 17, 25, 35, 45, 55, 65]
    
    var selectedAge: Int?
    var selectedIndex: Int?
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewPopUp.isHidden = true
        self.viewAge.layer.borderWidth = 1
        self.viewAge.layer.borderColor = colorGray.cgColor
        self.viewAge.layer.cornerRadius = 5
        self.viewAge.layer.masksToBounds = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        if appDelegate.selectedAgeIndex != nil {
            self.selectedAge = self.ageMiddleArray[appDelegate.selectedAgeIndex!]
            self.btnAge.setTitle(self.ageArray[appDelegate.selectedAgeIndex!], for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tableViewHeight.constant = self.tableView.contentSize.height
        }
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnAgeClicked(_ sender: Any) {
        self.viewPopUp.isHidden = false
    }
    
    @IBAction func btnContinueClicked(_ sender: Any) {
        if selectedAge == nil {
            showAlert(message: "Please select age", vc: self)
            return
        }
        appDelegate.age = self.selectedAge!
        print(appDelegate.age)
        if #available(iOS 13.0, *) {
            let obj = self.storyboard?.instantiateViewController(identifier: "StomachVC") as! StomachVC
            self.navigationController?.pushViewController(obj, animated: false)
        } else {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "StomachVC") as! StomachVC
            self.navigationController?.pushViewController(obj, animated: false)
        }
    }
    
    @IBAction func btnCloseAction(_ sender:UIButton) {
        self.dismissVC()
    }
}

extension SelectAgeVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgeCell") as! AgeCell
        cell.selectionStyle = .none
        cell.lblTitle.text = self.ageArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            return
        }
        self.selectedAge = self.ageMiddleArray[indexPath.row]
        self.btnAge.setTitle(self.ageArray[indexPath.row], for: .normal)
        self.viewPopUp.isHidden = true
        appDelegate.selectedAgeIndex = indexPath.row
    }
}
