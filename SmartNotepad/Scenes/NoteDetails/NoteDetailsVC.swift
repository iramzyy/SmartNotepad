//
//  NoteDetailsVC.swift
//  SmartNotepad
//
//  Created by Ramzy on 15/06/2021.
//

import UIKit

class NoteDetailsVC: UIViewController {
    
    @IBOutlet weak var notesTitleTextField: UITextField!
    @IBOutlet weak var notesBodyTextView: UITextView!
    @IBOutlet weak var addLocationButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var photoView: UIImageView!
    
    var presenter: NoteDetailsPresenterProtocols!
    var note: Note?
    
    private lazy var router: RouterProtocol = {
        let router = Router()
        router.presentedView = self
        return router
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = NoteDetailsPresenterImplementation(view: self, router: self.router, note: note)
        presenter.viewDidLoad()
    }
    
    
    
    
    @IBAction func addLocationPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func addPhotoPressed(_ sender: UIButton) {
    }
    
}

extension NoteDetailsVC: NoteDetailsViewProtocols {
    
    func handleAddUI() {
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
    
    func displayLocation(latitude: Double?, longitude: Double?) {
        if let noteLatitude = latitude , let noteLongitude = longitude {
            locationLabel.isHidden = false
            addLocationButton.isHidden = true
            locationLabel.text = presenter.getCoordinatesAddress(latitude: noteLatitude, longitue: noteLongitude)
        } else {
            locationLabel.isHidden = true
            addLocationButton.isHidden = false
        }
    }
    
    func displayPermissionAlert(title: String, message: String) {
        
    }
}
