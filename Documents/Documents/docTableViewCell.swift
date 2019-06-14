//
//  docTableViewCell.swift
//  Documents
//
//  Created by BryceLigaya on 6/10/19.
//  Copyright © 2019 Bl223LabCPU. All rights reserved.
//

import UIKit

class docTableViewCell: UITableViewCell {

    @IBOutlet weak var docNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(doc: Document) {
        self.docNameLabel.text = doc.docName?.uppercased()
        
    }

    
}
