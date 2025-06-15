//
//  WeatherViewModel.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/13.
//

import Foundation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    
    @Published var locations:[Location] = []
    @Published var todayWeather: Time?
    @Published var isLoading:Bool = false
    @Published var errorMessage:String?
    private var cancellables = Set<AnyCancellable>()
    private var service:WeatherServiceProtocol
    
    init(service: WeatherServiceProtocol = WeatherService()) {
        self.service = service
    }
    
    func fetchWeather() {
        isLoading = true
        service.fetchWeather()
            .sink { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { locations in
                self.errorMessage = nil
                self.locations = locations
                if let firstLocation = locations.first,
                   let wxElement = firstLocation.weatherElement.first(where: { $0.elementName == "Wx" }) {
                    self.todayWeather = wxElement.currentTimeEntry()
                }
            }
            .store(in: &cancellables)
    }
    
    func weatherForCurrentCity(_ cityName: String?) -> Location? {
        guard let cityName = cityName else { return nil }
        return locations.first(where: { $0.locationName == cityName })
    }
    
    func allFutureWeather(for cityName: String) -> [Time] {
        guard let location = locations.first(where: { $0.locationName == cityName }),
              let wx = location.weatherElement.first(where: { $0.elementName == "Wx" }) else {
            return []
        }
        return wx.time
    }
}

extension WeatherElement {
    func currentTimeEntry() -> Time? {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return time.first(where: { timeEntry in
            guard let start = formatter.date(from: timeEntry.startTime),
                  let end = formatter.date(from: timeEntry.endTime) else {
                return false
            }
            if start <= end {
                return now >= start && now <= end
            } else {
                return now >= start || now <= end
            }
        })
    }
}

extension String {
    func weatherSystemImageName() -> String {
        switch self {
        case let s where s.contains("晴"):
            return "sun.max.fill"
        case let s where s.contains("雷"):
            return "cloud.bolt.rain.fill"
        case let s where s.contains("雨"):
            return "cloud.rain.fill"
        case let s where s.contains("雲"):
            return "cloud.fill"
        case let s where s.contains("陰"):
            return "cloud"
        case let s where s.contains("雪"):
            return "cloud.snow.fill"
        default:
            return "questionmark.circle.fill"
        }
    }
}


