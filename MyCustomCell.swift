//
//  MyCustomCell.swift
//  TaskCommander
//
//  Created by Benjamin Tolman on 3/28/22.
//

import UIKit

class MyCustomCell: UITableViewCell {

    @IBOutlet weak var jobtitle_text: UILabel!
    @IBOutlet weak var jobAddress_text: UILabel!
    @IBOutlet weak var jobTimeDate_text: UILabel!
    @IBOutlet weak var jobNotes_text: UILabel!
    
    @IBOutlet weak var jobClientName_text: UILabel!
    @IBOutlet weak var jobAssigned_text: UILabel!
    
    @IBOutlet weak var jobStatus_text: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
