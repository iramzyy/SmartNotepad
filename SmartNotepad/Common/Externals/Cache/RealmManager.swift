//
//  RealmManager.swift
//  SmartNotepad
//
//  Created by Ramzy on 14/06/2021.
//

import Foundation
import RealmSwift

let realmObject = try! Realm()

class RealmManager: NSObject {
    
    static let sharedInstance = RealmManager()
    
    func retrieveAllDataForObject(_ T : Object.Type) -> [Object] {
        var objects = [Object]()
        for result in realmObject.objects(T).sorted(byKeyPath: "noteDate", ascending: false) {
            objects.append(result)
        }
        return objects
    }
    
    func deleteAllDataForObject(_ T : Object.Type) {
        self.delete(self.retrieveAllDataForObject(T))
    }
    
    func replaceAllDataForObject(_ T : Object.Type, with objects : [Object]) {
        deleteAllDataForObject(T)
        add(objects)
    }
    
    func add(_ objects : [Object], completion : @escaping() -> ()) {
        try! realmObject.write{
            realmObject.add(objects)
            completion()
        }
    }
    
    func add(_ objects : [Object]) {
        try! realmObject.write{
            realmObject.add(objects)
        }
    }
    
    func add(_ object: Object) {
        try! realmObject.write{
            realmObject.add(object)
        }
    }
    
    func update(_ block: @escaping ()->Void) {
        try! realmObject.write(block)
    }
    
    func delete(_ objects : [Object]) {
        try! realmObject.write{
            realmObject.delete(objects)
        }
    }
    
    func delete(_ object: Object) {
        try! realmObject.write{
            realmObject.delete(object)
        }
    }
}
