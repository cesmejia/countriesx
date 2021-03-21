//
//  CountriesDBRepository.swift
//  CountriesX
//
//  Created by Ces Mejia on 21/03/21.
//

import CoreData
import Combine

protocol CountriesDBRepository {
    func hasLoadedCountries() -> AnyPublisher<Bool, Error>
    
    func store(countries: [Country]) -> AnyPublisher<Void, Error>
    func countries(search: String, locale: Locale) -> AnyPublisher<LazyList<Country>, Error>
    
    func store(countryDetails: Country.Details.Intermediate,
               for country: Country) -> AnyPublisher<Country.Details?, Error>
    func countryDetails(country: Country) -> AnyPublisher<Country.Details?, Error>
}

//struct RealCountriesDBRepository: CountriesDBRepository {
//    let persistentStroe: PersistentStore
//    
//    func hasLoadedCountries() -> AnyPublisher<Bool, Error> {
//        <#code#>
//    }
//    
//    func store(countries: [Country]) -> AnyPublisher<Void, Error> {
//        <#code#>
//    }
//    
//    func countries(search: String, locale: Locale) -> AnyPublisher<LazyList<Country>, Error> {
//        <#code#>
//    }
//    
//    func store(countryDetails: Country.Details.Intermediate, for country: Country) -> AnyPublisher<Country.Details?, Error> {
//        <#code#>
//    }
//    
//    func countryDetails(country: Country) -> AnyPublisher<Country.Details?, Error> {
//        <#code#>
//    }
//}
