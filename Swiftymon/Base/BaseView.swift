//
//  BaseView.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

protocol BaseView: AnyObject {
    func showAlert(title: String, message: String)
    func showLoader()
    func hideLoader()
}
