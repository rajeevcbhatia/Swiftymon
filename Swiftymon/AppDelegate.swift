//
//  AppDelegate.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        showList()
        return true
    }

    private func showList() {
        let listPresenter = PokemonListPresenter(pokemonListService: PokemonListNetworkService())
        let listVC = PokemonListViewController(presenter: listPresenter)
        let navController = UINavigationController(rootViewController: listVC)
        window?.rootViewController = navController
    }
}

