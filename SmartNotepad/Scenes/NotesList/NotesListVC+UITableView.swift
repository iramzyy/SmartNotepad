//
//  NotesListVC+UITableView.swift
//  SmartNotepad
//
//  Created by Ramzy on 15/06/2021.
//

import UIKit.UITableView

extension NotesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.notesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as NoteCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}
