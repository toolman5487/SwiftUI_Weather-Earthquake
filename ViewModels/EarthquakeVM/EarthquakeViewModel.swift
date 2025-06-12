//
//  EarthquakeViewModel.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import Foundation
import SwiftUI
import Combine
import UIKit
import AudioToolbox

@MainActor
class EarthquakeViewModel: ObservableObject {
    
    @Published var earthquakes: [Earthquake] = []
    @Published var errorMessage: String?
    @Published var lastFlashedEarthquakeNo: Int?
    @Published var isAlarmActive: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private let service: EarthquakeServiceProtocol
    private let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    init(service: EarthquakeServiceProtocol = EarthquakeService()) {
        self.service = service
    }
    
    func fetchEarthquakeReport() {
        service.fetchEarthquakes()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error：\(error.localizedDescription)")
                }
            }, receiveValue: { earthquakes in
                self.earthquakes = earthquakes
                if let latest = earthquakes
                    .filter({ $0.earthquakeInfo.earthquakeMagnitude.magnitudeValue > 3.0 })
                    .sorted(by: { $0.earthquakeInfo.originTime > $1.earthquakeInfo.originTime })
                    .first,
                   latest.earthquakeNo != self.lastFlashedEarthquakeNo {
                    self.isAlarmActive = true
                    DispatchQueue.main.async {
                        self.impactGenerator.prepare()
                        self.impactGenerator.impactOccurred()
                        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                        AudioServicesPlaySystemSound(1005)
                        for second in 1...10 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + Double(second)) {
                                AudioServicesPlaySystemSound(1005)
                            }
                        }
                    }
                    self.lastFlashedEarthquakeNo = latest.earthquakeNo
                }
                print("fetch \(earthquakes.count) data")
                if earthquakes.isEmpty {
                    print("earthquakes isEmpty")
                } else if let first = earthquakes.first {
                    print("first earthquake：\(first)")
                }
            })
            .store(in: &cancellables)
    }
}

extension EarthquakeViewModel{
    
    var latestMagnitudeAboveThree: Earthquake? {
        earthquakes
            .filter { $0.earthquakeInfo.earthquakeMagnitude.magnitudeValue > 3.0 }
            .sorted { $0.earthquakeInfo.originTime > $1.earthquakeInfo.originTime }
            .first
    }
}
