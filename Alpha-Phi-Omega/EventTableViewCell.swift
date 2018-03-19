//
//  EventTableViewCell.swift
//  Alpha-Phi-Omega
//
//  Created by CheckoutUser on 3/19/18.
//  Copyright © 2018 Juan Ramirez. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventSummaryLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
