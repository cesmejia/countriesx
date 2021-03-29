//
//  UserPermissionsService.swift
//  CountriesX
//
//  Created by Cesar Mejia Valero on 28/03/21.
//

import Foundation

enum Permission {
    case pushNotifications
}

extension Permission {
    enum Status: Equatable {
        case unknown
        case notRequested
        case granted
        case denied
    }
}
