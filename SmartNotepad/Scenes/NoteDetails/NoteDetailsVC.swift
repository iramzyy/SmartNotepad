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
        setGestureRecognizers()
        presenter = NoteDetailsPresenterImplementation(view: self,
                                                       router: self.router,
                                                       locationManager: locationManger,
                                                       imagePikerManager: imagePikerManager,
                                                       note: note)
        presenter.viewDidLoad()
    }
    
    func setGestureRecognizers() {
        let locationTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleLocationTapped(_:)))
        locationLabel.addGestureRecognizer(locationTapGesture)
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleImageTapped(_:)))
        photoView.addGestureRecognizer(imageTapGesture)
    }
    
    @objc func handleLocationTapped(_ sender: UITapGestureRecognizer? = nil) {
        presenter.addLocationPressed()
    }
    
    @objc func handleImageTapped(_ sender: UITapGestureRecognizer? = nil) {
        presenter.addImagePressed()
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

