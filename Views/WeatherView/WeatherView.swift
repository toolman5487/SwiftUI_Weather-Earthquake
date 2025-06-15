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
    @State private var selectedLocationName: String? = nil
    
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
                            Button {
                                selectedLocationName = location.locationName
                            } label: {
                                Text(location.locationName)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(selectedLocationName == location.locationName ? Color.blue.opacity(0.3) : Color(uiColor: .secondarySystemBackground))
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
                .frame(height: 40)
                Divider()
                
                if let selectedName = selectedLocationName,
                   let location = weatherVM.weatherForCurrentCity(selectedName),
                   let wx = location.weatherElement.first(where: { $0.elementName == "Wx" }) {
                    List {
                        ForEach(weatherVM.allFutureWeather(for: selectedName), id: \.startTime) { timeEntry in
                            let temps = weatherVM.temperatureForTime(timeEntry, in: location)
                            WeatherTimeRowView(timeEntry: timeEntry, minTemp: temps.min, maxTemp: temps.max)
                        }
                    }
                } else {
                    Spacer()
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .foregroundColor(.secondary)
                    Text("請從上方選擇地點")
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                }
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
