//
//  Storyboards.swift
//  SmartNotepad
//
//  Created by Ramzy on 14/06/2021.
//

import UIKit.UIViewController
import UIKit.UIStoryboard

extension UIViewController {
    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}

extension UIStoryboard {
    class func instantiateInitialViewController(_ id: Storyboard) -> UIViewController {
        let story = UIStoryboard(name: id.rawValue, bundle: nil)
        return story.instantiateInitialViewController()!
    }
}

public enum Storyboard: String {
    case NotesList
    case NoteDetails

    public func viewController<VC: UIViewController>(_ viewController: VC.Type) -> VC {
        guard
            let vc = UIStoryboard(name: self.rawValue, bundle: nil)
                .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
            else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)") }
        
        return vc
    }
    
    public func initialViewController() -> UIViewController {
        let story = UIStoryboard(name: self.rawValue, bundle: nil)
        guard let vc = story.instantiateInitialViewController() else { fatalError("\(self.rawValue) has no InitialViewController") }
        return vc
    }
}
