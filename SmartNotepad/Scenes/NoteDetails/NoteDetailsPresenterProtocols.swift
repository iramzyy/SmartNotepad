//
//  NoteDetailsPresenterProtocols.swift
//  SmartNotepad
//
//  Created by Ramzy on 15/06/2021.
//

import Foundation

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
