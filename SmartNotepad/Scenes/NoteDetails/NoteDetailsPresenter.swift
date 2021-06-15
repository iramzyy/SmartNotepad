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
    func displayPermissionAlert(title: String, message: String)
}

protocol NoteDetailsPresenterProtocols {
    func viewDidLoad()
    func backPressed()
    func getCoordinatesAddress(latitude: Double, longitue: Double) -> String
    func addNotePressed(title: String, body: String, image: Data?, latitude: String? , longitude: String?)
}

class NoteDetailsPresenterImplementation: NoteDetailsPresenterProtocols {

    
    
    fileprivate weak var view: NoteDetailsViewProtocols?
    fileprivate let realmManager: RealmManager = RealmManager()
    private let router: RouterProtocol
    private let note: Note?
    
    
    init(view: NoteDetailsViewProtocols, router: RouterProtocol, note: Note?) {
        self.view = view
        self.router = router
        self.note = note
    }
    
    
    func viewDidLoad() {
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
    
    func getCoordinatesAddress(latitude: Double, longitue: Double) -> String {
        let geocoder = CLGeocoder()
        var addressString : String = ""
        geocoder.reverseGeocodeLocation(CLLocation(latitude:latitude, longitude: longitue)) {(placeMarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
                
            }

            if let places = placeMarks {
                if places.count > 0 {
                    let place = places[0]
                    if place.subLocality != nil {
                        addressString = addressString + place.subLocality! + ", "
                    }
                    if place.thoroughfare != nil {
                        addressString = addressString + place.thoroughfare! + ", "
                    }
                    if place.locality != nil {
                        addressString = addressString + place.locality! + ", "
                    }
                    if place.country != nil {
                        addressString = addressString + place.country! + ", "
                    }
                    if place.postalCode != nil {
                        addressString = addressString + place.postalCode! + " "
                    }
                }
            }
        }
        return addressString
    }
    
    func addNotePressed(title: String, body: String, image: Data?, latitude: String?, longitude: String?) {
        
    }
    
}
