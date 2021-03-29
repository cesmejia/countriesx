//
//  CountriesListViewModel.swift
//  CountriesX
//
//  Created by Cesar Mejia Valero on 29/03/21.
//

import SwiftUI
import Combine

// MARK: - Routing

extension CountriesList {
    struct Routing: Equatable {
        var countryDetails: Country.Code?
    }
}
