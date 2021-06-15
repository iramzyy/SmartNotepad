//
//  NoteCell.swift
//  SmartNotepad
//
//  Created by Ramzy on 14/06/2021.
//

import UIKit

class NoteCell: UITableViewCell {
    // MARK:- IBOutlets
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteBodyLabel: UILabel!
    @IBOutlet weak var nearestLabel: UILabel!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var imageIcon: UIImageView!
    
}

extension NoteCell : NoteCellProtocols {
    func display(title: String) {
        noteTitleLabel.text = title
    }
    
    func display(body: String) {
        noteBodyLabel.text = body
    }
    
    func display(image: Data?) {
        if image == nil {
            imageIcon.isHidden = true
        } else {
            imageIcon.isHidden = false
        }
    }
    
    func display(isNearestLabel : Bool) {
        isNearestLabel == true ? (nearestLabel.isHidden = false) : (nearestLabel.isHidden = true)
    }
    
    func displayLocation(latitude: Double?, longitude: Double?) {
        if latitude == nil && longitude == nil {
            locationIcon.isHidden = true
        } else {
            locationIcon.isHidden = false
        }
    }
}
