//
//  NoteDetailsVC.swift
//  SmartNotepad
//
//  Created by Ramzy on 15/06/2021.
//

import UIKit


class NoteDetailsVC: UIViewController {
    @IBOutlet weak var deleteBarButton: UIBarButtonItem!
    
    @IBOutlet weak var notesTitleTextField: UITextField!
    @IBOutlet weak var notesBodyTextView: UITextView!
    @IBOutlet weak var addLocationButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var photoView: UIImageView!
    
    var presenter: NoteDetailsPresenterProtocols!
    var imagePickerController:UIImagePickerController?
    var note: Note?

    
    private lazy var router: RouterProtocol = {
        let router = Router()
        router.presentedView = self
        return router
    }()
    
    private lazy var locationManger: LocationManager = {
        return LocationManager.shared
    }()
    
    private lazy var imagePikerManager: ImagePicker = {
        let imagePicker = ImagePicker(presentationController: self, delegate: self)
        return imagePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NoteDetailsPresenterImplementation(view: self, router: self.router, locationManager: locationManger, imagePikerManager: imagePikerManager, note: note)
        presenter.viewDidLoad()
    }
    
    
    
    
    @IBAction func addLocationPressed(_ sender: UIButton) {
        presenter.addLocationPressed()
    }
    
    
    @IBAction func addPhotoPressed(_ sender: UIButton) {
        presenter.addImagePressed()
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        presenter.deletePressed()
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        presenter.addNotePressed(title: notesTitleTextField.text,
                                 body: notesBodyTextView.text)
    }
}



extension NoteDetailsVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        presenter.didSelectImage(imageData: image?.pngData())
    }
}


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
