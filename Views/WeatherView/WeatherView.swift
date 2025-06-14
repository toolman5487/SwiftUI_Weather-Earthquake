//
//  WeatherView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI

struct WeatherHomeView: View {
    
    @StateObject var locationManager = LocationManager()
    @StateObject var weatherVM = WeatherViewModel()
    @State private var shake = false
    
    var body: some View {
        NavigationView{
            VStack{
                if let location = weatherVM.weatherForCurrentCity(locationManager.cityName) {
                    TodayWeatherView(location: location)
                } else {
                    LoadingLocationView()
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(weatherVM.locations, id: \.locationName) { location in
                            Text(location.locationName)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color(uiColor: .secondarySystemBackground))
                                .cornerRadius(20)
                        }
                    }
                }
                .frame(height: 40)
                
                Spacer()
            }
            .navigationTitle("天氣預報")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        print("Location Top")
                        locationManager.requestLocation()
                    }) {
                        Image(systemName: locationManager.cityName == nil ? "location.slash.fill" : "location.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.primary)
                    }
                }
            }
        }
        .onAppear {
            locationManager.requestLocation()
            weatherVM.fetchWeather()
        }
    }
}

#Preview {
    WeatherHomeView()
}
