//
//  NotesListVC.swift
//  SmartNotepad
//
//  Created by Ramzy on 14/06/2021.
//

import UIKit

class NotesListVC: UIViewController {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var notesTableView: UITableView!
    @IBOutlet weak var addFloatingButton: UIButton!
    
    var presenter: NotesPresenterProtocols!
    
    private lazy var router: RouterProtocol = {
        let router = Router()
        router.presentedView = self
        return router
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter = NotesPresenterImplementation(view: self, router: self.router)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
    private func setupUI() {
        setupFloatingButton()
        setupTableView()
    }
    

    
    private func setupFloatingButton() {
        addFloatingButton.cornerRadius = addFloatingButton.frame.width / 2
    }
    
    private func setupTableView() {
        notesTableView.registerCellNib(cellClass: NoteCell.self)
        notesTableView.dataSource = self
        notesTableView.delegate = self
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        presenter.addButtonPressed()
    }
}
