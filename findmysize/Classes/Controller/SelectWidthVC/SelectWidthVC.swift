//
//  SelectWidthVC.swift
//  Femi9Tracking
//
//  Created by Piyush on 13/04/21.
//

import UIKit

class SelectWidthVC: UIViewController {
    
    //MARK:- @IBOutlet
    @IBOutlet weak var lblHeightType:UILabel!
    @IBOutlet weak var viewSegment: UIView!
    @IBOutlet weak var btnLBS: UIButton!
    @IBOutlet weak var btnKG: UIButton!
    @IBOutlet weak var ViewWidth: UIView!
    @IBOutlet weak var widthCollectionView: UICollectionView!
    
    //MARK:- Variables
    var isLBSValue: Bool = false
    var totalValue: Int = 115
    var selectedIndex: Int = 14
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set size default
        self.widthCollectionView.delegate = self
        self.widthCollectionView.dataSource = self
        self.widthCollectionView.reloadData()
        self.lblHeightType.text = "50kg"
        if widthIndex != nil {
            self.isLBSValue = isLBS
            self.selectedIndex = widthIndex!
            self.showSegment(index:  self.isLBSValue ? 0 : 1)
        }
        else {
            self.showSegment(index: self.isLBSValue ? 0 : 1)
        }
        viewSegment.layer.borderColor = colorGray.cgColor
        viewSegment.layer.borderWidth = 2
        viewSegment.layer.cornerRadius = 5
        viewSegment.layer.masksToBounds = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.widthCollectionView.scrollToItem(at: IndexPath(row: self.selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
    //Show segments
    func showSegment(index: Int) {
        self.btnLBS.backgroundColor = .white
        self.btnKG.backgroundColor = .white
        self.btnLBS.setTitleColor(colorGray, for: .normal)
        self.btnKG.setTitleColor(colorGray, for: .normal)
        
        if index == 0 {
            self.btnLBS.backgroundColor = colorGray
            self.btnLBS.setTitleColor(.white, for: .normal)
        }
        else {
            self.btnKG.backgroundColor = colorGray
            self.btnKG.setTitleColor(.white, for: .normal)
        }
    }
    
    //Convert Lbs to kg
    func convertLbsToKg() -> Int {
        return Int(Double(self.selectedIndex + 36) * Double(0.453592))
    }
    
    //MARK:- @IBAction
    //Move to next screen
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    //Remove index
    @IBAction func btnDownClicked(_ sender: Any) {
        if isLBSValue {
            if selectedIndex == 0 {
                return
            }
            self.selectedIndex -= 1
            self.lblHeightType.text = "\(self.selectedIndex + 36)lbs"
        }
        else {
            if selectedIndex == 0 {
                return
            }
            self.selectedIndex -= 1
            self.lblHeightType.text = "\(self.selectedIndex + 36)kg"
        }
        self.widthCollectionView.scrollToItem(at: IndexPath(row: self.selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    //Increase index
    @IBAction func btnUpClicked(_ sender: Any) {
        if isLBSValue {
            if selectedIndex == 293 {
                return
            }
            self.selectedIndex += 1
            self.lblHeightType.text = "\(self.selectedIndex + 36)lbs"
        }
        else {
            if selectedIndex == 114 {
                return
            }
            self.selectedIndex += 1
            self.lblHeightType.text = "\(self.selectedIndex + 36)kg"
        }
        self.widthCollectionView.scrollToItem(at: IndexPath(row: self.selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    //Move to next screen
    @IBAction func btnContinueClicked(_ sender: Any) {
        kWeight = isLBSValue ? self.convertLbsToKg() : (self.selectedIndex + 36)
        isLBS = self.isLBSValue
        widthIndex = self.selectedIndex
        if #available(iOS 13.0, *) {
            let obj = self.storyboard?.instantiateViewController(identifier: "SelectAgeVC") as! SelectAgeVC
            self.navigationController?.pushViewController(obj, animated: false)
        } else {
            let obj = self.storyboard?.instantiateViewController(withIdentifier: "SelectAgeVC") as! SelectAgeVC
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
    
    //Change Segment
    @IBAction func btnSegmentClicked(_ sender: UIButton) {
        if sender == self.btnLBS {
            if self.isLBSValue {
                return
            }
            self.isLBSValue = true
            self.lblHeightType.text = "135lbs"
            self.totalValue = 294
            self.selectedIndex = 99
            self.showSegment(index: 0)
        } else {
            if !self.isLBSValue {
                return
            }
            self.isLBSValue = false
            self.lblHeightType.text = "50kg"
            self.totalValue = 115
            self.selectedIndex = 14
            self.showSegment(index: 1)
        }
        self.widthCollectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.widthCollectionView.scrollToItem(at: IndexPath(row: self.selectedIndex, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
    //Close screen
    @IBAction func btnCloseAction(_ sender:UIButton) {
        self.dismissVC()
    }
}

extension SelectWidthVC:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK:- CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionView.bounds.width / 2, bottom: 0, right: collectionView.bounds.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.totalValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.widthCollectionView.dequeueReusableCell(withReuseIdentifier: "WidthCell", for: indexPath) as! WidthCell
        if (indexPath.row%4) == 0 {
            cell.viewBig.isHidden = false
            cell.viewSmall.isHidden = true
        } else {
            cell.viewBig.isHidden = true
            cell.viewSmall.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 6, height: 115)
    }
    
    //MARK:- ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexPath = widthCollectionView.indexPathForItem(at: widthCollectionView.bounds.center)
        if indexPath == nil {
            return
        }
        self.selectedIndex = indexPath?.row ?? 0
        if isLBSValue {
            self.lblHeightType.text = "\((indexPath?.row ?? 0) + 36)lbs"
        }
        else {
            self.lblHeightType.text = "\((indexPath?.row ?? 0) + 36)kg"
        }
    }
}
