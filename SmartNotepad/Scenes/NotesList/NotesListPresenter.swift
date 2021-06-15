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
    private let locationManager: LocationManager
    private let router: RouterProtocol
    private var notes = [Note]()
    
    var notesCount: Int {
        return  notes.count
    }
    
    init(view: NotesListViewProtocols, router: RouterProtocol,locationManager: LocationManager) {
        self.view = view
        self.router = router
        self.locationManager = locationManager
    }
    
    func viewWillAppear() {
        locationManager.updateCurrentLocation()
        getNotes()
    }
    
    func getNotes() {
        notes.removeAll()
        let realmNotes =  realmManager.retrieveAllDataForObject(Note.self).map{ $0 as! Note }
        
        if realmNotes.count == 0 {
            view?.handleEmptyNotesView()
        } else {
            if let nearestNote = getNearestNote(notes: realmNotes) {
                notes.append(nearestNote)
                notes.append(contentsOf: realmNotes.filter({ $0.noteID != nearestNote.noteID}))
            } else {
                notes = realmNotes
            }
            DispatchQueue.main.async {
                self.view?.refreshListView()
            }
        }
    }
    
    func getNearestNote(notes: [Note]) -> Note? {
        var smallestDistance: Double?
        var nearestNote: Note?
        if let currentLocation = locationManager.getCurrentLocation()?.coordinate {
            for note in notes {
                if let noteLatitude = note.noteLatitude.value,
                   let noteLongitude = note.noteLongitude.value {
                    let distance = locationManager.getDistanceInMeters(currentLatitude: currentLocation.latitude, currentLongitude: currentLocation.longitude, locationLatitude: noteLatitude, locationLongitude: noteLongitude)
                    if smallestDistance == nil || distance < smallestDistance! {
                        nearestNote = note
                        smallestDistance = distance
                    }
                }
            }
        }
        nearestNote?.nearestLocation = true
        return nearestNote
    }
    
    func configure(cell: NoteCell, forRow row: Int) {
        let note = notes[row]
        
        cell.display(title: note.noteTitle)
        cell.display(body: note.noteBody)
        cell.display(image: note.noteImageData)
        cell.display(isNearestLabel: note.nearestLocation)
        cell.displayLocation(latitude: note.noteLatitude.value, longitude: note.noteLongitude.value)
    }
    
    func didSelect(row: Int) {
        let note = notes[row]
        let noteDetailsVC = Storyboard.NoteDetails.viewController(NoteDetailsVC.self)
        noteDetailsVC.note = note
        DispatchQueue.main.async {
            self.router.push(view: noteDetailsVC)
        }
    }
    
    func refreshButtonPressed() {
        locationManager.updateCurrentLocation()
        getNotes()
    }
    
    func addButtonPressed() {
        let noteDetailsVC = Storyboard.NoteDetails.viewController(NoteDetailsVC.self)
        DispatchQueue.main.async {
            self.router.push(view: noteDetailsVC)
        }
    }
}
