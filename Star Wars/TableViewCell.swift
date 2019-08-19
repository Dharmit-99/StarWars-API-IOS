//
//  TableViewCell.swift
//  Star Wars
//
//  Created by Dharmit Mahendra on 1/5/2016.
//  Copyright © 2019 Dharmit Mahendra. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var nextPage: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
