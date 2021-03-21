//
//  Models+CoreData.swift
//  CountriesX
//
//  Created by Ces Mejia on 21/03/21.
//

import Foundation
import CoreData

extension CountryMO: ManagedEntity { }
extension NameTranslationMO: ManagedEntity { }
extension CountryDetailsMO: ManagedEntity { }
extension CurrencyMO: ManagedEntity { }

extension Locale {
    static var backendDefault: Locale {
        return Locale(identifier: "en")
    }
    
    var shortIdentifier: String {
        return String(identifier.prefix(2))
    }
}


extension Country {
    
    @discardableResult
    func store(in context: NSManagedObjectContext) -> CountryMO? {
        guard let country = CountryMO.insertNew(in: context)
            else { return nil }
        country.name = name
        country.alpha3code = alpha3Code
        country.population = Int32(population)
        country.flagURL = flag?.absoluteString
        let translations = self.translations
            .compactMap { (locale, name) -> NameTranslationMO? in
                guard let name = name,
                    let translation = NameTranslationMO.insertNew(in: context)
                else { return nil }
                translation.name = name
                translation.locale = locale
                return translation
            }
        country.nameTranslations = NSSet(array: translations)
        return country
    }
    
    init?(managedObject: CountryMO) {
        guard let nameTranslations = managedObject.nameTranslations
            else { return nil }
        let translations: [String: String?] = nameTranslations
            .toArray(of: NameTranslationMO.self)
            .reduce([:], { (dict, record) -> [String: String?] in
                guard let locale = record.locale, let name = record.name
                    else { return dict }
                var dict = dict
                dict[locale] = name
                return dict
            })
        guard let name = managedObject.name,
            let alpha3code = managedObject.alpha3code
            else { return nil }
        
        self.init(name: name, translations: translations,
                  population: Int(managedObject.population),
                  flag: managedObject.flagURL.flatMap { URL(string: $0) },
                  alpha3Code: alpha3code)
    }
}
