//
//  Storyboards.swift
//  SmartNotepad
//
//  Created by Ramzy on 14/06/2021.
//

import UIKit.UIStoryboard


enum Storyboards: String {
    case notesList = ""
}

protocol Storyboarded {
    static func instantiate(_ storyboardId: Storyboards) -> Self
}

extension Storyboarded where Self:UIViewController {
    static func instantiate(_ storyboardId: Storyboards) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardId.rawValue ,bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
