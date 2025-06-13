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
    
    private var cancellables = Set<AnyCancellable>()
    private let service: EarthquakeServiceProtocol
    private let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
    @Published var earthquakes: [Earthquake] = []
    @Published var errorMessage: String?
    @Published var lastFlashedEarthquakeNo: Int? {
        didSet {
            if let no = lastFlashedEarthquakeNo {
                UserDefaults.standard.set(no, forKey: "lastFlashedEarthquakeNo")
            }
        }
    }
    @Published var isAlarmActive: Bool = false
    
    init(service: EarthquakeServiceProtocol = EarthquakeService()) {
        self.service = service
        let savedNo = UserDefaults.standard.integer(forKey: "lastFlashedEarthquakeNo")
        self.lastFlashedEarthquakeNo = savedNo == 0 ? nil : savedNo
    }
    
    func fetchEarthquakeReport() {
        print("Before assignment, lastFlashedEarthquakeNo: \(String(describing: lastFlashedEarthquakeNo))")
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
                
                if let latest = self.latestStrongIntensityEarthquake {
                    let maxIntensity = latest.intensity.shakingArea.compactMap { area in
                        Int(area.areaIntensity.replacingOccurrences(of: "級", with: ""))
                    }.max() ?? 0
                    
                    if maxIntensity >= 3 && latest.earthquakeNo != self.lastFlashedEarthquakeNo {
                        self.isAlarmActive = true
                        DispatchQueue.main.async {
                            self.impactGenerator.prepare()
                            self.impactGenerator.impactOccurred()
                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                            AudioServicesPlaySystemSound(1005)
                            for second in 1...3 {
                                DispatchQueue.main.asyncAfter(deadline: .now() + Double(second)) {
                                    AudioServicesPlaySystemSound(1005)
                                }
                            }
                        }
                        self.lastFlashedEarthquakeNo = latest.earthquakeNo
                    }
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
    
    var latestStrongIntensityEarthquake: Earthquake? {
        earthquakes
            .filter { earthquake in
                earthquake.intensity.shakingArea.contains { area in
                    if let intensityValue = Int(area.areaIntensity.replacingOccurrences(of: "級", with: "")) {
                        return intensityValue >= 3
                    }
                    return false
                }
            }
            .sorted { $0.earthquakeInfo.originTime > $1.earthquakeInfo.originTime }
            .first
    }
}
