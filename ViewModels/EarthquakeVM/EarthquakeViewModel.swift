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
        print("開始抓地震資料")
        service.fetchEarthquakes()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("地震資料取得失敗：\(error.localizedDescription)")
                }
            }, receiveValue: { earthquakes in
                self.earthquakes = earthquakes
                print("成功取得地震資料：共 \(earthquakes.count) 筆")
                if earthquakes.isEmpty {
                    print("抓到的 earthquakes 是空的")
                } else if let first = earthquakes.first {
                    print("第一筆地震：\(first)")
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
