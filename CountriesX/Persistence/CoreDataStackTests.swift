//
//  CoreDataStackTests.swift
//  CountriesXTests
//
//  Created by Ces Mejia on 21/03/21.
//

import XCTest
import Combine
@testable import CountriesX

class CoreDataStackTests: XCTestCase {
    
    var sut: CoreDataStack!
    let testDirectory: FileManager.SearchPathDirectory = .cachesDirectory
    var dbVersion: UInt { fatalError("Override") }
    var cancelBag = CancelBag()

    override func setUp()  {
        eraseDBFiles()
        sut = CoreDataStack(directory: testDirectory, version: dbVersion)
    }

    override func tearDown()  {
        cancelBag = CancelBag()
        sut = nil
        eraseDBFiles()
    }
    
    func eraseDBFiles() {
        let version = CoreDataStack.Version(dbVersion)
        if let url = version.dbFileURL(testDirectory, .userDomainMask) {
            try? FileManager().removeItem(at: url)
        }
    }
}

// MARK: - Version 1

final class CoreDataStackV1Tests: CoreDataStackTests {
    override var dbVersion: UInt { 1 }
    
    func test_initialization() {
        let exp = XCTestExpectation(description: #function)
        let request = CountryMO.newFetchRequest()
        request.predicate = NSPredicate(value: true)
        request.fetchLimit = 1
        sut.fetch(request) { _ -> Int? in
            return nil
        }.sinkToResult { result in
            result.assertSuccess(value: LazyList<Int>.empty)
            exp.fulfill()
        }
        .store(in: cancelBag)
        wait(for: [exp], timeout: 1)
    }
}
