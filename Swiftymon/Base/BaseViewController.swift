//
//  BaseViewController.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController, BaseView {
    
    func showLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            MBProgressHUD.showAdded(to: strongSelf.view, animated: true)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showRetryAlert(title: String, message: String, callback: @escaping (() -> ())) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let retryAction = UIAlertAction(title: "Retry", style: UIAlertAction.Style.cancel) { (action) in
            callback()
        }
        alertController.addAction(retryAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
