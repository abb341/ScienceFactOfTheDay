//
//  RecentFactTableViewCell.swift
//  Tips
//
//  Created by Aaron Brown on 7/13/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import UIKit

class RecentFactTableViewCell: UITableViewCell {

    @IBOutlet weak var forDate: UILabel!
    @IBOutlet weak var contentOfFact: UILabel!
    /*
    var recentFact: RecentFact? {
        didSet {
            if let recentFact = recentFact, contentOfFact = contentOfFact, forDate = forDate {
                //self.contentOfFact.text = recentFact.contentOfFact
                //forDate.text = "\(recentFact.forDate)"
            }
        }
    }*/
    
    var recentFact: Fact?     
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
