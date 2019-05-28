//
//  PokemonListViewTests.swift
//  SwiftymonTests
//
//  Created by Rajeev Bhatia on 26/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest
@testable import Swiftymon

class PokemonListViewControllerTests: XCTestCase {
    
    var pokemonListPresenter: PokemonListPresenter?
    var pokemonListVC: PokemonListViewController?

    override func setUp() {
        pokemonListPresenter = PokemonListPresenter(pokemonListService: MockPokemonListService())
        guard let presenter = pokemonListPresenter else {
            XCTFail("could not init pokemon list presenter")
            return
        }
        pokemonListVC = PokemonListViewController(presenter: presenter)
        _ = pokemonListVC?.view
    }

    override func tearDown() {
        pokemonListVC = nil
        pokemonListPresenter = nil
    }
    
    func testMorePokemonLoadedOnScroll() {
        guard let presenter = pokemonListPresenter, let vc = pokemonListVC else {
            XCTFail("pokemonListVC test components not initialised")
            return
        }
        
        let expectation = XCTestExpectation(description: "pokemon loaded")
        
        //to give the vc enough time to add items to tableview first
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        
            let numberOfRowsOld = vc.pokemonListTableView.numberOfRows(inSection: 0)
            
            presenter.nextPagePath = MockListPageTypes.pageWithNext.rawValue
            
        vc.pokemonListTableView.prefetchDataSource?.tableView(vc.pokemonListTableView, prefetchRowsAt: [IndexPath(row: numberOfRowsOld - 5, section: 0)])
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let numberOfRowsNew = vc.pokemonListTableView.numberOfRows(inSection: 0)
                
                XCTAssert(numberOfRowsNew > numberOfRowsOld, "no new pokemon loaded on scroll")
                expectation.fulfill()
            }
        }
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 10.0)
        
    }
    
    func testDidShowDetailsOnTap() {
        
        guard let _ = pokemonListPresenter, let vc = pokemonListVC else {
            XCTFail("pokemonListVC test components not initialised")
            return
        }
        
        let navigationController = UINavigationController(rootViewController: vc)
        _ = navigationController.view
        
        let expectation = XCTestExpectation(description: "pokemon loaded")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            let numberOfRows = vc.pokemonListTableView.numberOfRows(inSection: 0)
            
            XCTAssert(numberOfRows > 0, "no pokemon loaded on start")
            
            vc.tableView(vc.pokemonListTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                guard let top = navigationController.topViewController, top is PokemonDetailsViewController else {
                    XCTFail("details not shown after tapping row")
                    expectation.fulfill()
                    return
                }
                expectation.fulfill()
            }
        }
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 10.0)
        
    }

}
