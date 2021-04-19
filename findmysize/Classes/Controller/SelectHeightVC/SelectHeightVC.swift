//
//  SelectHeightVC.swift
//  Femi9Tracking
//
//  Created by iMac on 12/04/21.
//

import UIKit

//MARK:- Size return delegate
protocol FemiTrackingDelegate: class  {
    func FemiTrackingFinish(size: String)
}

class SelectHeightVC: UIViewController {
    
    //MARK:- @IBOutlet
    @IBOutlet weak var tblSelectHeight:UITableView!
    @IBOutlet weak var lblHeightType:UILabel!
    @IBOutlet weak var viewSegment: UIView!
    @IBOutlet weak var btnFT: UIButton!
    @IBOutlet weak var btnCM: UIButton!
    
    //MARK:- Variables
    weak var delegate: FemiTrackingDelegate?
    var isFTValue: Bool = false
    var totalValue: Int = 57
    var selectedIndex: Int = 8
    var arrayFT: [String] = []
    var categoryName: String = ""
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide navigation bar
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name(Size_notification_key), object: nil)
        
        //Check size available
        let (isSelected, size) =  self.checkISSelected()
        if isSelected {
            self.delegate?.FemiTrackingFinish(size: size)
            self.dismiss(animated: false, completion: nil)
            return
        }
        
        //Set size default
        tblSelectHeight.isHidden = false
        tblSelectHeight.reloadData()
        self.lblHeightType.text = "160cm"
        self.showSegment(index: 1)
        
        viewSegment.layer.borderColor = colorGray.cgColor
        viewSegment.layer.borderWidth = 2
        viewSegment.layer.cornerRadius = 5
        viewSegment.layer.masksToBounds = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tblSelectHeight.scrollToRow(at: IndexPath(row: self.selectedIndex, section: 0), at: .none, animated: false)
        }
        self.addArrayFT()
    }
    
    //Make FT Array
    func addArrayFT() {
        var ft: Int = 0
        var position: Int = 11
        
        for _ in 0..<134 {
            if position == 12 {
                position = 0
                ft += 1
                arrayFT.append("\(ft)ft")
            }
            else {
                arrayFT.append("\(ft)ft \(position)in")
            }
            position += 1
        }
    }
    
    //Finish size selection
    @objc func methodOfReceivedNotification(notification: Notification) {
        let (_, size) =  self.checkISSelected()
        /*if isSelected {
         self.delegate?.FemiTrackingFinish(size: size)
         }*/
        self.delegate?.FemiTrackingFinish(size: size)
        self.dismiss(animated: false, completion: nil)
    }
    
    //Check size is available
    func checkISSelected() -> (Bool, String) {
        let json = loadJSON(key: Measurement_key)
        if json.isEmpty {
            return (false, "")
        }
        
        let model = MeasurementsModel(JSON: json.dictionaryObject!)
        let filter = model?.data?.sizes?.filter({ (data) -> Bool in
            return data.name == self.categoryName
        })
        let isSelected = filter?.count == 0 ? false : true
        return (isSelected, filter?.first?.size ?? "")
    }
    
    //Show segments
    func showSegment(index: Int) {
        self.btnFT.backgroundColor = .white
        self.btnCM.backgroundColor = .white
        self.btnFT.setTitleColor(colorGray, for: .normal)
        self.btnCM.setTitleColor(colorGray, for: .normal)
        
        if index == 0 {
            self.btnFT.backgroundColor = colorGray
            self.btnFT.setTitleColor(.white, for: .normal)
        }
        else {
            self.btnCM.backgroundColor = colorGray
            self.btnCM.setTitleColor(.white, for: .normal)
        }
    }
    
    //Convert FT to CM
    func convertFtToCm() -> Int {
        let array = self.arrayFT[self.selectedIndex].components(separatedBy: " ")
        let ft = Int(array[0].replacingOccurrences(of: "ft", with: "")) ?? 0
        var inch = 0
        if array.count == 2 {
            inch  = Int(array[1].replacingOccurrences(of: "in", with: "")) ?? 0
        }
        let inchVal: Double = 30.48 * Double(ft)
        let feetVal: Double = 2.54 * Double(inch)
        return Int(Double(inchVal + feetVal))
    }
    
    //Get FT to index
    func getFT(index: Int) -> String {
        if self.arrayFT.count == 0 || self.arrayFT.count <= index {
            return ""
        }
        return self.arrayFT[index]
    }
    
    //MARK:- @IBAction
    //Move to next screen
    @IBAction func btnContinueClicked(_ sender: Any) {
        kHeight = isFTValue ? self.convertFtToCm() : (self.selectedIndex + 142)
        isFT = isFTValue
        heightIndex = self.selectedIndex
        
        if #available(iOS 13.0, *) {
            let obj = self.storyboard?.instantiateViewController(identifier: "SelectWidthVC") as! SelectWidthVC
            self.navigationController?.pushViewController(obj, animated: false)
        } else {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "SelectWidthVC") as! SelectWidthVC
            self.navigationController?.pushViewController(obj, animated: false)
        }
    }
    
    //Move to Privacy screen
    @IBAction func btnPrivacyClicked(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let obj = self.storyboard?.instantiateViewController(identifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
            self.navigationController?.pushViewController(obj, animated: false)
        } else {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "PrivacyPolicyVC") as! PrivacyPolicyVC
            self.navigationController?.pushViewController(obj, animated: false)
        }
    }
    
    //Remove index
    @IBAction func btnDownClicked(_ sender: Any) {
        if isFTValue {
            if selectedIndex == 0 {
                return
            }
            self.selectedIndex -= 1
            self.lblHeightType.text = self.getFT(index: self.selectedIndex)
        }
        else {
            if selectedIndex == 0 {
                return
            }
            self.selectedIndex -= 1
            self.lblHeightType.text = "\(self.selectedIndex + 142)cm"
        }
        self.tblSelectHeight.scrollToRow(at: IndexPath(row: self.selectedIndex, section: 0), at: .none, animated: false)
    }
    
    //Increase index
    @IBAction func btnUpClicked(_ sender: Any) {
        if isFTValue {
            if selectedIndex >= 133 {
                return
            }
            self.selectedIndex += 1
            self.lblHeightType.text = self.getFT(index: self.selectedIndex)
            self.tblSelectHeight.scrollToRow(at: IndexPath(row: self.selectedIndex, section: 0), at: .none, animated: false)
        }
        else {
            if selectedIndex == 56 {
                return
            }
            self.selectedIndex += 1
            self.lblHeightType.text = "\(self.selectedIndex + 142)cm"
            self.tblSelectHeight.scrollToRow(at: IndexPath(row: self.selectedIndex, section: 0), at: .none, animated: false)
        }
    }
    
    //Change Segment
    @IBAction func btnSegmentClicked(_ sender: UIButton) {
        if sender == self.btnFT {
            if self.isFTValue {
                return
            }
            self.isFTValue = true
            self.lblHeightType.text = "5ft"
            self.totalValue = 134
            self.selectedIndex = 8
            self.showSegment(index: 0)
        } else {
            if !self.isFTValue {
                return
            }
            self.isFTValue = false
            self.lblHeightType.text = "152.4cm"
            self.totalValue = 57
            self.selectedIndex = 8
            self.showSegment(index: 1)
        }
        self.tblSelectHeight.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tblSelectHeight.scrollToRow(at: IndexPath(row: self.selectedIndex, section: 0), at: .none, animated: false)
        }
    }
    
    //Close screen
    @IBAction func btnCloseAction(_ sender:UIButton) {
        self.dismissVC()
    }
}

extension SelectHeightVC:UITableViewDelegate,UITableViewDataSource {
    //MARK:- Tablview Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 95
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.totalValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeightCell") as! HeightCell
        if (indexPath.row%4) == 0 {
            cell.viewBig.isHidden = false
            cell.viewSmall.isHidden = true
        } else {
            cell.viewBig.isHidden = true
            cell.viewSmall.isHidden = false
        }
        return cell
    }
    
    //MARK:- ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexPath = tblSelectHeight.indexPathForRow(at: tblSelectHeight.bounds.center)
        if indexPath == nil {
            return
        }
        self.selectedIndex = indexPath?.row ?? 0
        if isFTValue {
            self.lblHeightType.text = self.getFT(index: indexPath?.row ?? 0)
        }
        else {
            self.lblHeightType.text = "\((indexPath?.row ?? 0) + 142)cm"
        }
    }
}
