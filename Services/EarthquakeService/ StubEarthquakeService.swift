//
//   StubEarthquakeService.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import Foundation
import Combine

struct StubEarthquakeService: EarthquakeServiceProtocol {
    func fetchEarthquakes() -> AnyPublisher<[Earthquake], Error> {
        let quake = Earthquake.mock
        return Just([quake])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
