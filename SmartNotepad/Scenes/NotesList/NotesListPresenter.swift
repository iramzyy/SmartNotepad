//
//  NotesListPresenter.swift
//  SmartNotepad
//
//  Created by Ramzy on 15/06/2021.
//

import Foundation

class NotesPresenterImplementation: NotesPresenterProtocols {
    private weak var view: NotesListViewProtocols?
    private let realmManager: RealmManager = RealmManager()
    private let router: RouterProtocol
    private var notes = [Note]()
    
    var notesCount: Int {
        return  notes.count
    }
    
    init(view: NotesListViewProtocols, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func viewWillAppear() {
        getNotes()
    }
    
    func getNotes() {
        notes =  realmManager.retrieveAllDataForObject(Note.self).map{ $0 as! Note }
        if notes.count == 0 {
            view?.handleEmptyNotesView()
        } else {
            view?.refreshListView()
        }
    }
    
    func configure(cell: NoteCell, forRow row: Int) {
        let note = notes[row]
        
        cell.display(title: note.noteTitle)
        cell.display(body: note.noteBody)
        cell.display(image: note.noteImageData)
        cell.displayLocation(latitude: note.noteLatitude.value, longitude: note.noteLongitude.value)
        
    }
    
    func didSelect(row: Int) {
        let note = notes[row]
        let noteDetailsVC = Storyboard.NoteDetails.viewController(NoteDetailsVC.self)
        noteDetailsVC.note = note
        router.push(view: noteDetailsVC)
    }
    
    func addButtonPressed() {
        let noteDetailsVC = Storyboard.NoteDetails.viewController(NoteDetailsVC.self)
        router.push(view: noteDetailsVC)
    }
}
