//
//  NoteCell.swift
//  SmartNotepad
//
//  Created by Ramzy on 14/06/2021.
//

import UIKit

class NoteCell: UITableViewCell {
    @IBOutlet weak var noteBodyLabel: UILabel!
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var nearestLabel: UILabel!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var imageIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
