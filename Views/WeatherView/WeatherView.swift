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
    
    var body: some View {
        NavigationView{
            VStack {
                if let location = weatherVM.weatherForCurrentCity(locationManager.cityName) {
                    Text("\(location.locationName)")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    if let wx = location.weatherElement.first(where: { $0.elementName == "Wx" }) {
                        if let time = wx.currentTimeEntry() ?? wx.time.first {
                            let weatherDescription = time.parameter.parameterName
                            let systemImageName = weatherDescription.weatherSystemImageName()
                            Image(systemName: systemImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                            
                            Text(weatherDescription)
                                .foregroundColor(Color.secondary)
                        }
                    }
                } else {
                    Text("找不到該地點天氣")
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(weatherVM.locations, id: \.locationName) { location in
                            Text(location.locationName)
                                .padding(4)
                                .background(Color(uiColor: .secondarySystemBackground))
                                .cornerRadius(4)
                        }
                    }
                }
                .frame(height: 40)
                .padding()
                Spacer()
            }
            .navigationTitle("天氣預報")
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
