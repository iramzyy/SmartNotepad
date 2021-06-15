//
//  NoteDetailsVC+ViewProtocols.swift
//  SmartNotepad
//
//  Created by Ramzy on 15/06/2021.
//

import UIKit.UIImage
import UIKit.UIApplication

extension NoteDetailsVC: NoteDetailsViewProtocols {
    
    func handleAddUI() {
        deleteBarButton.image = nil
        deleteBarButton.isEnabled = false
        addLocationButton.isHidden = false
        locationLabel.isHidden = true
        addPhotoButton.isHidden = false
        photoView.isHidden = true
    }
    
    func display(title: String) {
        notesTitleTextField.text = title
    }
    
    func display(body: String) {
        notesBodyTextView.text = body
    }
    
    func display(image: Data?) {
        if let imageData = image {
            photoView.isHidden = false
            addPhotoButton.isHidden = true
            photoView.image = UIImage(data: imageData)
        } else {
            photoView.isHidden = true
            addPhotoButton.isHidden = false
        }
    }
    
    func display(locationAddress: String) {
        locationLabel.text = locationAddress
    }
    
    func displayLocation(latitude: Double?, longitude: Double?) {
        if let noteLatitude = latitude , let noteLongitude = longitude {
            locationLabel.isHidden = false
            addLocationButton.isHidden = true
            presenter.getCoordinatesAddress(latitude: noteLatitude, longitue: noteLongitude)
        } else {
            locationLabel.isHidden = true
            addLocationButton.isHidden = false
        }
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
