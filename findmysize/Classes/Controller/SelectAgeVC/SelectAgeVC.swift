//
//  SelectAgeVC.swift
//  Femi9Tracking
//
//  Created by Piyush on 13/04/21.
//

import UIKit

class SelectAgeVC: UIViewController {
    
    //MARK:- @IBOutlet
    @IBOutlet weak var viewAge: UIView!
    @IBOutlet weak var btnAge: UIButton!
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    //MARK:- Variables
    var ageArray: [String] = ["Select age", "14 - 20", "20 - 30", "30 - 40", "40 - 50", "50 - 60", "60+"]
    var ageMiddleArray: [Int] = [0, 17, 25, 35, 45, 55, 65]
    var selectedAge: Int?
    var selectedIndex: Int?
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide popup
        self.viewPopUp.isHidden = true
        
        //Layer view update
        self.viewAge.layer.borderWidth = 1
        self.viewAge.layer.borderColor = colorGray.cgColor
        self.viewAge.layer.cornerRadius = 5
        self.viewAge.layer.masksToBounds = true
        
        //TableView delegates
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
        if selectedAgeIndex != nil {
            self.selectedAge = self.ageMiddleArray[selectedAgeIndex!]
            self.btnAge.setTitle(self.ageArray[selectedAgeIndex!], for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tableViewHeight.constant = self.tableView.contentSize.height
        }
    }
    
    //MARK:- @IBAction
    //Back previous screen
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    //Show Age popup
    @IBAction func btnAgeClicked(_ sender: Any) {
        self.viewPopUp.isHidden = false
    }
    
    //Move to hips screen
    @IBAction func btnContinueClicked(_ sender: Any) {
        if selectedAge == nil {
            showAlert(message: "Please select age", vc: self)
            return
        }
        kAge = self.selectedAge!
        if #available(iOS 13.0, *) {
            let obj = self.storyboard?.instantiateViewController(identifier: "SelectStomachVC") as! SelectStomachVC
            self.navigationController?.pushViewController(obj, animated: false)
        } else {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "SelectStomachVC") as! SelectStomachVC
            self.navigationController?.pushViewController(obj, animated: false)
        }
    }
    
    @IBAction func btnCloseAction(_ sender:UIButton) {
        self.dismissVC()
    }
}

extension SelectAgeVC:UITableViewDelegate,UITableViewDataSource {
    //MARK: - TableView delegates
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
        selectedAgeIndex = indexPath.row
    }
}
