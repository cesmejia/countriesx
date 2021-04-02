//
//  ContentView.swift
//  CountriesX
//
//  Created by Ces Mejia on 18/03/21.
//

import SwiftUI

struct ContentView: View {
//    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

// MARK: - ViewModel

extension ContentView {
    class ViewModel: ObservableObject {
        
        let container: DIContainer
        let isRunningTests: Bool

        init(container: DIContainer, isRunningTests: Bool = ProcessInfo.processInfo.isRunningTests) {
            self.container = container
            self.isRunningTests = isRunningTests
        }

        var onChangeHandler: (EnvironmentValues.Diff) -> Void { // TODO: Install: SwiftUI Environment Overrides
            return { diff in
                if !diff.isDisjoint(with: [.locale, .sizeCategory]) {
                    self.container.appState[\.routing] = AppState.ViewRouting()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
