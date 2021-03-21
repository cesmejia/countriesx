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
