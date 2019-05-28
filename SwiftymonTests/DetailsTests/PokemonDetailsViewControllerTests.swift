//
//  PokemonDetailsViewControllerTests.swift
//  SwiftymonTests
//
//  Created by Rajeev Bhatia on 28/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest
@testable import Swiftymon

class PokemonDetailsViewControllerTests: XCTestCase {
    
    func testDetailsShownWithNoEvolution() {
        let pokemonId = MockPokemonId.mew
        
        let sut = getSut(id: pokemonId)
        
        let pokemonDetailsViewController = sut.vc
        
        guard let detailsWithEvolution = pokemonId.detailsWithEvolution else {
            XCTFail("details not fetched")
            return
        }
        pokemonDetailsViewController.didFetch(detailsWithEvolution: detailsWithEvolution)
        
        let expectation = XCTestExpectation(description: "details loaded")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssert(pokemonDetailsViewController.evolutionCollection.isHidden == true, "evolution shown for mew")
            expectation.fulfill()
        }
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 3.0)
    }
    
    func testDetailsShownWithTwoLevelEvolution() {
        let pokemonId = MockPokemonId.eevee
        
        let sut = getSut(id: pokemonId)
        
        let pokemonDetailsViewController = sut.vc
        
        guard let detailsWithEvolution = pokemonId.detailsWithEvolution else {
            XCTFail("details not fetched")
            return
        }
        pokemonDetailsViewController.didFetch(detailsWithEvolution: detailsWithEvolution)
        
        let expectation = XCTestExpectation(description: "details loaded")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssert(pokemonDetailsViewController.evolutionCollection.isHidden == false, "evolution not shown for eevee")
            
            let evolutionCount = pokemonDetailsViewController.evolutionCollection.numberOfItems(inSection: 0)
            XCTAssert(evolutionCount == 2, "\(evolutionCount) level evolution shown for eevee")
            
            expectation.fulfill()
        }
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 3.0)
    }
    
    func testDetailsShownWithThreeLevelEvolution() {
        let pokemonId = MockPokemonId.oddish
        
        let sut = getSut(id: pokemonId)
        
        let pokemonDetailsViewController = sut.vc
        
        guard let detailsWithEvolution = pokemonId.detailsWithEvolution else {
            XCTFail("details not fetched")
            return
        }
        pokemonDetailsViewController.didFetch(detailsWithEvolution: detailsWithEvolution)
        
        let expectation = XCTestExpectation(description: "details loaded")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssert(pokemonDetailsViewController.evolutionCollection.isHidden == false, "evolution not shown for oddish")
            
            let evolutionCount = pokemonDetailsViewController.evolutionCollection.numberOfItems(inSection: 0)
            XCTAssert(evolutionCount == 3, "\(evolutionCount) level evolution shown for oddish")
            
            expectation.fulfill()
        }
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 3.0)
    }

    
    private func getSut(id: MockPokemonId) -> SUT {
        let pokemonDetailsService = MockPokemonDetailsService(pokemonId: id.rawValue)
        
        let pokemonDetailsPresenter = PokemonDetailsPresenter(pokemonDetailsService: pokemonDetailsService)
        let pokemonDetailsViewController = PokemonDetailsViewController(presenter: pokemonDetailsPresenter)
        _ = pokemonDetailsViewController.view
        return (pokemonDetailsPresenter, pokemonDetailsViewController)
    }
}

private typealias SUT = (presenter: PokemonDetailsPresenter, vc: PokemonDetailsViewController)
