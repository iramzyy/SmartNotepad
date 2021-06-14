//
//  NotesListVC.swift
//  SmartNotepad
//
//  Created by Ramzy on 14/06/2021.
//

import UIKit

class NotesListVC: UIViewController {
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var addFloatingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    private func setupUI() {
        setupFloatingButton()
    }
    
    private func setupFloatingButton() {
        addFloatingButton.cornerRadius = addFloatingButton.frame.width / 2
    }
    


}
