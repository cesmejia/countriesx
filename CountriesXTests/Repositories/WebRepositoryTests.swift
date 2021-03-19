//
//  WebRepositoryTests.swift
//  CountriesXTests
//
//  Created by Ces Mejia on 18/03/21.
//

import XCTest
import Combine
@testable import CountriesX

class WebRepositoryTests: XCTestCase {
    
    private var sut: TestWebRepository!
    private var subscriptions = Set<AnyCancellable>()
    
    private typealias API = TestWebRepository.API
    typealias Mock = RequestMocking.MockedResponse
    
    override func setUp()  {
        subscriptions = Set<AnyCancellable>()
        sut = TestWebRepository()
    }

    override func tearDown()  {
        RequestMocking.removeAllMocks()
    }

    func test_webRepository_success() throws {
        let data = TestWebRepository.TestData()
        try mock(.test, result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.load(.test).sinkToResult { result in
            XCTAssertTrue(Thread.isMainThread)
            result.assertSuccess(value: data)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    // MARK: - Helper
    
    private func mock<T>(_ apiCall: API, result: Result<T, Swift.Error>, httpCode: HTTPCode = 200) throws where T: Encodable {
        let mock = try Mock(apiCall: apiCall, baseURL: sut.baseURL, result: result, httpCode: httpCode)
        RequestMocking.add(mock: mock)
    }
}

private extension TestWebRepository {
    func load(_ api: API) -> AnyPublisher<TestData, Error> {
        call(endpoint: api)
    }
}

extension TestWebRepository {
    enum API: APICall {
        
        case test
        case urlError
        case bodyError
        case noHttpCodeError
        
        var path: String {
            if self == .urlError {
                return "😋😋😋"
            }
            return "/test/path"
        }
        var method: String { "POST" }
        var headers: [String: String]? { nil }
        func body() throws -> Data? {
            if self == .bodyError { throw APIError.fail }
            return nil
        }
    }
}

extension TestWebRepository {
    enum APIError: Swift.Error, LocalizedError {
        case fail
        var errorDescription: String? { "fail" }
    }
}

extension TestWebRepository {
    struct TestData: Codable, Equatable {
        let string: String
        let integer: Int
        
        init() {
            string = "some string"
            integer = 42
        }
    }
}
