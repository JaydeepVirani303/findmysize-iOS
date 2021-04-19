//
//  HeightCell.swift
//  Femi9Tracking
//
//  Created by iMac on 12/04/21.
//

import UIKit

class HeightCell: UITableViewCell {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var viewBig:UIView!
    @IBOutlet weak var viewSmall:UIView!
    
    //MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
