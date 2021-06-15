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
    func backPressed()
    func getCoordinatesAddress(latitude: Double, longitue: Double)
    func addLocationPressed()
    func addNotePressed(title: String, body: String, image: Data?, latitude: String? , longitude: String?)
}

class NoteDetailsPresenterImplementation: NoteDetailsPresenterProtocols {

    fileprivate weak var view: NoteDetailsViewProtocols?
    fileprivate let realmManager: RealmManager = RealmManager()
    private let router: RouterProtocol
    private let locationManager: LocationManager
    private let note: Note?
    
    
    init(view: NoteDetailsViewProtocols, router: RouterProtocol,locationManager: LocationManager ,note: Note?) {
        self.view = view
        self.router = router
        self.locationManager = locationManager
        self.note = note
    }
    
    
    func viewDidLoad() {
        locationManager.updateCurrentLocation()
        if note != nil {
            view?.display(title: note!.noteTitle)
            view?.display(body: note!.noteBody)
            view?.display(image: note?.noteImageData)
            view?.displayLocation(latitude: note?.noteLatitude.value, longitude: note?.noteLongitude.value)
        } else {
            view?.handleAddUI()
        }
    }
    
    func backPressed() {
        
    }
    
    func getCoordinatesAddress(latitude: Double, longitue: Double){
        locationManager.getLocationAddress(CLLocation(latitude: latitude, longitude: longitue)) { address in
            guard let address = address else {return}
            self.view?.display(locationAddress: address)
        }
    }
    
    func addLocationPressed() {
        if locationManager.hasLocationPermission() {
        view?.displayLocation(latitude: locationManager.getCurrentLocation()?.coordinate.latitude,
                              longitude:  locationManager.getCurrentLocation()?.coordinate.longitude)
        } else {
            let settingsAction : AlertAction = ("Settings", .default, {self.view?.openSettings()})
            let cancelAction: AlertAction = ("Cancel", .cancel, { })
            router.alertWithAction(title: " Location Permission Required",
                                   message: "Please enable location permissions in settings.",
                                   alertStyle: .alert,
                                   actions: [settingsAction,cancelAction])
        }
    }
    
    func addNotePressed(title: String, body: String, image: Data?, latitude: String?, longitude: String?) {
        
    }
    
}
