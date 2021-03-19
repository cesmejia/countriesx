//
//  MockedWebRepositories.swift
//  CountriesXTests
//
//  Created by Ces Mejia on 18/03/21.
//

import XCTest
import Combine
@testable import CountriesX

class TestWebRepository: WebRepository {
    let session: URLSession = .mockedResponsesOnly
    let baseURL = "https://test.com"
    let bgQueue = DispatchQueue(label: "test")
}
