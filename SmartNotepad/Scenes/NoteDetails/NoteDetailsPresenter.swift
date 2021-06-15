//
//  NoteDetailsPresenter.swift
//  SmartNotepad
//
//  Created by Ramzy on 15/06/2021.
//

import Foundation
import CoreLocation

protocol NoteDetailsViewProtocols: AnyObject {
    func handleAddUI()
    func display(title : String)
    func display(body: String)
    func display(image: Data?)
    func displayLocation(latitude: Double?, longitude: Double?)
    func display(locationAddress: String)
    func openSettings()
}

protocol NoteDetailsPresenterProtocols {
    func viewDidLoad()
    func getCoordinatesAddress(latitude: Double, longitue: Double)
    func addLocationPressed()
    func addImagePressed()
    func didSelectImage(imageData: Data?)
    func addNotePressed(title: String?, body: String?)
    func deletePressed()
}

class NoteDetailsPresenterImplementation: NoteDetailsPresenterProtocols {
    fileprivate weak var view: NoteDetailsViewProtocols?
    fileprivate let realmManager: RealmManager = RealmManager()
    private let router: RouterProtocol
    private let imagePikerManager: ImagePicker
    private let locationManager: LocationManager
    private let note: Note?
    private var selectedImage: Data?
    private var selectedLatitude: Double?
    private var selectedLongitude: Double?
    
    
    init(view: NoteDetailsViewProtocols, router: RouterProtocol,locationManager: LocationManager,imagePikerManager: ImagePicker ,note: Note?) {
        self.view = view
        self.router = router
        self.locationManager = locationManager
        self.imagePikerManager = imagePikerManager
        self.note = note
    }
    
    
    func viewDidLoad() {
        locationManager.updateCurrentLocation()
        if note != nil {
            selectedImage = note?.noteImageData
            selectedLatitude = note?.noteLatitude.value
            selectedLongitude = note?.noteLongitude.value
            view?.display(title: note!.noteTitle)
            view?.display(body: note!.noteBody)
            view?.display(image: note?.noteImageData)
            view?.displayLocation(latitude: note?.noteLatitude.value, longitude: note?.noteLongitude.value)
        } else {
            view?.handleAddUI()
        }
    }
    
    func getCoordinatesAddress(latitude: Double, longitue: Double){
        locationManager.getLocationAddress(CLLocation(latitude: latitude, longitude: longitue)) { address in
            guard let address = address else {return}
            self.view?.display(locationAddress: address)
        }
    }
    
    func addLocationPressed() {
        if locationManager.hasLocationPermission() {
            selectedLatitude = locationManager.getCurrentLocation()?.coordinate.latitude
            selectedLongitude = locationManager.getCurrentLocation()?.coordinate.longitude
            view?.displayLocation(latitude: selectedLatitude,
                                  longitude: selectedLongitude)
        } else {
            let settingsAction : AlertAction = ("Settings", .default, {self.view?.openSettings()})
            let cancelAction: AlertAction = ("Cancel", .cancel, { })
            router.alertWithAction(title: " Location Permission Required",
                                   message: "Please enable location permissions in settings.",
                                   alertStyle: .alert,
                                   actions: [settingsAction,cancelAction])
        }
    }
    
    
    func addImagePressed() {
        if imagePikerManager.hasPhotoLibraryPermission() {
            imagePikerManager.present(from: router.presentedView.view)
        } else {
            let settingsAction : AlertAction = ("Settings", .default, {self.view?.openSettings()})
            let cancelAction: AlertAction = ("Cancel", .cancel, { })
            router.alertWithAction(title: " Access Photo Permission Required",
                                   message: "Please enable access photo permissions in settings.",
                                   alertStyle: .alert,
                                   actions: [settingsAction,cancelAction])
        }
    }
    
    func didSelectImage(imageData: Data?) {
        selectedImage = imageData
        view?.display(image: imageData)
    }
    
    func addNotePressed(title: String?, body: String?) {
        guard let noteTitle = title, !noteTitle.isEmpty else { return }
        
        guard let noteBody = body, !noteBody.isEmpty else { return }
        if note != nil {
            realmManager.update {
                self.note?.noteTitle = noteTitle
                self.note?.noteBody = noteBody
                self.note?.noteImageData = self.selectedImage
                self.note?.noteLatitude.value = self.selectedLatitude
                self.note?.noteLongitude.value = self.selectedLongitude
            }
        } else {
            let newNote = Note()
            newNote.noteTitle = noteTitle
            newNote.noteBody = noteBody
            newNote.noteImageData = selectedImage
            newNote.noteLatitude.value = selectedLatitude
            newNote.noteLongitude.value = selectedLongitude
            realmManager.add(newNote)
        }
        router.pop()
    }
    
    func deletePressed() {
        if let note = note {
            realmManager.delete(note)
            router.pop()
        }
    }
}
