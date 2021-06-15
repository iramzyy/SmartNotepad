//
//  NotesListPresenterProtocols.swift
//  SmartNotepad
//
//  Created by Ramzy on 15/06/2021.
//

import Foundation

protocol NotesListViewProtocols: AnyObject {
    func startLoading()
    func finishLoading()
    func refreshListView()
    func handleEmptyNotesView()
}

protocol NoteCellProtocols: AnyObject {
    func display(title : String)
    func display(body: String)
    func display(image: Data?)
    func display(isNearestLabel: Bool)
    func displayLocation(latitude: Double?, longitude: Double?)
}

protocol NotesPresenterProtocols {
    var notesCount: Int { get }
    func viewWillAppear()
    func configure(cell: NoteCell, forRow row: Int)
    func didSelect(row: Int)
    func refreshButtonPressed()
    func addButtonPressed()
}
