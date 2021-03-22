//
//  CountriesDBRepositoryTests.swift
//  CountriesXTests
//
//  Created by Ces Mejia on 22/03/21.
//

import XCTest
import Combine
@testable import CountriesX

class CountriesDBRepositoryTests: XCTestCase {
    
    var mockedStore: MockedPersistentStore!
    var sut: RealCountriesDBRepository!
    var cancelBag = CancelBag()

    override func setUp()  {
        mockedStore = MockedPersistentStore()
        sut = RealCountriesDBRepository(persistentStore: mockedStore)
        mockedStore.verify()
    }

    override func tearDown()  {
        cancelBag = CancelBag()
        sut = nil
        mockedStore = nil
    }
}

// MARK: - Countries list
    
final class CountriesListDBRepoTests: CountriesDBRepositoryTests {
    func test_hasLoadedCountries() {
        mockedStore.actions = .init(expected: [
            .count,
            .count
        ])
        let exp = XCTestExpectation(description: #function)
        mockedStore.countResult = 0
        sut.hasLoadedCountries()
            .flatMap { value -> AnyPublisher<Bool, Error> in
                XCTAssertFalse(value)
                self.mockedStore.countResult = 10
                return self.sut.hasLoadedCountries()
            }
            .sinkToResult { result in
                result.assertSuccess(value: true)
                self.mockedStore.verify()
                exp.fulfill()
            }
            .store(in: cancelBag)
        wait(for: [exp], timeout: 0.5)
    }
}
