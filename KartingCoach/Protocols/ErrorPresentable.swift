//
//  ErrorPresentable.swift
//  KartingCoach
//
//  Created by Lukáš Hromadník on 10.09.17.
//

import UIKit
import ReactiveSwift

protocol ErrorPresentable {
    func displayErrors<Input, Output, Error>(for action: Action<Input, Output, Error>) where Error: DisplayableError
}

extension UIViewController: ErrorPresentable {
    
    func displayErrors<Input, Output, Error>(for action: Action<Input, Output, Error>) where Error: DisplayableError {
        action.errors.take(during: reactive.lifetime).observeValues { [unowned self] error in
            let alertController = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: L10n.Basic.ok, style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }

}
