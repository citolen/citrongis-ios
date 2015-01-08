//
//  RatingStoreTableViewCell.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 1/6/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import UIKit

class RatingStoreTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var priceBtn: UIButton!
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
