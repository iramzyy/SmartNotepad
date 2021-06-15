//
//  NoteDetailsVC+ImagePicker.swift
//  SmartNotepad
//
//  Created by Ramzy on 15/06/2021.
//

import UIKit.UIImage

extension NoteDetailsVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        presenter.didSelectImage(imageData: image?.pngData())
    }
}
