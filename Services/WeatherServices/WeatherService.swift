//
//  WeatherService.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/13.
//

import Foundation
import Combine

protocol WeatherServiceProtocol {
    func fetchWeather() -> AnyPublisher<[Location], Error>
}

class WeatherService:WeatherServiceProtocol {
    
    func fetchWeather() -> AnyPublisher<[Location], Error> {
        guard let apiKey = Bundle.main.infoDictionary?["CWBApiKey"] as? String else {
            return Fail(error: URLError(.userAuthenticationRequired)).eraseToAnyPublisher()
        }
        let urlString = "https://opendata.cwa.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=\(apiKey)&format=JSON"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                let decoded = try JSONDecoder().decode(WeatherModel.self, from: data)
                return decoded.records.location
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
