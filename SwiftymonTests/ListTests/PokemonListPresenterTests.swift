//
//  PokemonListPresenterTests.swift
//  SwiftymonTests
//
//  Created by Rajeev Bhatia on 26/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest
@testable import Swiftymon

class PokemonListPresenterTests: XCTestCase {

    var presenter: PokemonListPresenter?
    
    override func setUp() {
        presenter = PokemonListPresenter(pokemonListService: MockPokemonListService())
        
    }
    
    override func tearDown() {
        presenter = nil
    }
    
    func testNotifyFlagIsTrueOnStart() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        XCTAssert(presenter.shouldNotifyOnSrollToEnd, "list presenter notify flag is false on start")
    }
    
    func testNotifyFlagIsTrueOnMoreResponse() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        presenter.nextPagePath = MockListPageTypes.pageWithNext.rawValue
        
        presenter.didScrollToLastRows()
        
        XCTAssert(presenter.shouldNotifyOnSrollToEnd, "list presenter notify flag is false when there are more items")
    }

    func testNotifyFlagIsTrueOnFailure() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        presenter.nextPagePath = MockListPageTypes.pageWithNext.rawValue
        
        presenter.didScrollToLastRows()
        
        XCTAssert(presenter.shouldNotifyOnSrollToEnd, "list presenter notify flag is false when there are more items")
    }

    func testNotifyFlagIsFalseOnNoMoreResponse() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        presenter.nextPagePath = MockListPageTypes.pageWithoutNext.rawValue
        
        presenter.didScrollToLastRows()
        
        XCTAssertFalse(presenter.shouldNotifyOnSrollToEnd, "list presenter notify flag is true when there are no more items")
    }
    
    func testPokemonAreAddedWhenViewIsAttached() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        let mockView  = MockPokemonListView(presenter: presenter)
        
        XCTAssertFalse(mockView.wasAddPokemonCalled, "pokemon were added without attaching presenter")
        
        presenter.attach(view: mockView)
        
        XCTAssert(mockView.wasAddPokemonCalled, "pokemon were not added after view was attached")
    }
    
    func testWillGoToDetailsWhenPokemonIsSelected() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        let mockView  = MockPokemonListView(presenter: presenter)
        
        presenter.attach(view: mockView)
        presenter.didSelectPokemon(id: "1")
        
        XCTAssert(mockView.willGoToDetails, "not going to details on selecting pokemon")
    }
    
    func testRetryAlertIsShownOnError() {
        guard let presenter = presenter else { XCTFail("list presenter was not initialised"); return }
        
        let mockView  = MockPokemonListView(presenter: presenter)
        
        presenter.nextPagePath = MockListPageTypes.failure.rawValue
        
        XCTAssertFalse(mockView.wasRetryAlertShown, "retry alert was shown without error")
        
        presenter.attach(view: mockView)
        
        XCTAssert(mockView.wasRetryAlertShown, "retry alert was not shown on error response")
        
    }
}


private class MockPokemonListView: PokemonListView {
    
    
    private let presenter: PokemonListPresentable
    var wasAddPokemonCalled = false
    var willGoToDetails = false
    var wasRetryAlertShown = false
    
    required init(presenter: PokemonListPresentable) {
        self.presenter = presenter
    }
    
    func addPokemon(items: [Pokemon]) {
        wasAddPokemonCalled = true
    }
    
    func showAlert(title: String, message: String) {
        
    }
    
    func showLoader() {
        
    }
    
    func hideLoader() {
        
    }
    
    func goToDetails(id: String) {
        willGoToDetails = true
    }
    
    func showRetryAlert(title: String, message: String, callback: @escaping (() -> ())) {
        wasRetryAlertShown = true
    }
}
