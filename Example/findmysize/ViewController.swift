//
//  ViewController.swift
//  findmysize
//
//  Created by Jaydeep on 04/18/2021.
//  Copyright (c) 2021 Jaydeep. All rights reserved.
//

import UIKit
import findmysize

class ViewController: UIViewController {
    
    //MARK:- @IBOutlet
    @IBOutlet weak var btnMySize:UIButton!
    
    //MARK:- Variables
    let obj = FindMySize()
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- @IBAction
    @IBAction func btnFindMyFitAction(_ sender: UIButton) {
//        let strCurrentSize = obj.getSizeByAttribute(attributeName: "Outer Wear-FREE")
//        if strCurrentSize.isEmpty {
            obj.openSizePopup(userId: "1", attributeName: "Dresses",controller: self)
            obj.handlerUpdate = {[weak self] size in
                self?.btnMySize.setTitle("Your size is \(size)", for: .normal)
            }
//        } else {
//            btnMySize.setTitle("Your size is \(strCurrentSize)", for: .normal)
//        }
    }
}

