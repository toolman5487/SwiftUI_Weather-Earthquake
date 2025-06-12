//
//  EarthquakeViewModel.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class EarthquakeViewModel: ObservableObject {
    
    @Published var earthquakes: [Earthquake] = []
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    private let service: EarthquakeServiceProtocol
    
    init(service: EarthquakeServiceProtocol = EarthquakeService()) {
        self.service = service
    }
    
    func fetchEarthquakeReport() {
        service.fetchEarthquakes()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { earthquakes in
                self.earthquakes = earthquakes
            })
            .store(in: &cancellables)
    }
}
