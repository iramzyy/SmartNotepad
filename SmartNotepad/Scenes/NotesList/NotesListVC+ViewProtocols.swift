//
//  NotesListVC+ViewProtocols.swift
//  SmartNotepad
//
//  Created by Ramzy on 15/06/2021.
//

extension NotesListVC: NotesListViewProtocols {
    func refreshListView() {
        emptyView.isHidden = true
        notesTableView.isHidden = false
        notesTableView.reloadData()
    }
    
    func handleEmptyNotesView() {
        notesTableView.isHidden = true
        emptyView.isHidden = false
    }
}
