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

        setupUI()
    }
    
    private func setupUI() {
        setupFloatingButton()
        setupTableView()
    }
    
    private func setupFloatingButton() {
        addFloatingButton.cornerRadius = addFloatingButton.frame.width / 2
    }
    
    private func setupTableView() {
        notesTableView.registerCellNib(cellClass: NoteCell.self)
        notesTableView.dataSource = self
        notesTableView.delegate = self
    }
    
}


extension NotesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as NoteCell
        
        return cell
    }
}
