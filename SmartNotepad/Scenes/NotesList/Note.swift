//
//  Note.swift
//  SmartNotepad
//
//  Created by Ramzy on 14/06/2021.
//

import Foundation
import RealmSwift

class Note: Object {
    @objc dynamic var noteID = UUID().uuidString
    @objc dynamic var noteTitle: String = "Note title"
    @objc dynamic var noteBody: String = "Note body"
    @objc dynamic var noteImageData: Data?  = nil
    var noteLatitude = RealmOptional<Double>()
    var noteLongitude = RealmOptional<Double>()
    

    override static func primaryKey() -> String? {
      return "noteID"
    }
}
