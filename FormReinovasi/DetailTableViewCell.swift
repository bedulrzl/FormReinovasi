//
//  DetailTableViewCell.swift
//  FormReinovasi
//
//  Created by Aprizal on 12/12/20.
//  Copyright © 2020 Aprizal. All rights reserved.
//

import UIKit
import SwipeCellKit

class DetailTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var nameForm: UILabel!
    @IBOutlet weak var emailForm: UILabel!
    @IBOutlet weak var jenisForm: UILabel!
    @IBOutlet weak var lahirForm: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
