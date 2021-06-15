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
    @objc dynamic var noteTitle: String = ""
    @objc dynamic var noteBody: String = ""
    @objc dynamic var noteImageData: Data?  = nil
    @objc dynamic var noteDate = Date()
    dynamic var noteLatitude = RealmOptional<Double>()
    dynamic var noteLongitude = RealmOptional<Double>()
    
    var nearestLocation: Bool = false
    

    override static func primaryKey() -> String? {
      return "noteID"
    }
}
