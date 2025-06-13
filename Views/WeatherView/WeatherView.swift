//
//  WeatherView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI

struct WeatherDay: Identifiable {
    let id = UUID()
    let date: String
    let iconName: String
    let maxTemp: Int
    let minTemp: Int
}

struct WeatherHomeView: View {
    let forecastDays: [WeatherDay] = [
        WeatherDay(date: "週一", iconName: "cloud.sun.fill", maxTemp: 30, minTemp: 22),
        WeatherDay(date: "週二", iconName: "cloud.rain.fill", maxTemp: 27, minTemp: 20),
        WeatherDay(date: "週三", iconName: "sun.max.fill", maxTemp: 32, minTemp: 24),
        WeatherDay(date: "週四", iconName: "cloud.bolt.fill", maxTemp: 28, minTemp: 21),
        WeatherDay(date: "週五", iconName: "cloud.sun.rain.fill", maxTemp: 29, minTemp: 23),
    ]
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                VStack {
                    Text("台北市")
                        .font(.title)
                        .bold()
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 72))
                        .foregroundColor(.yellow)
                    Text("28°C")
                        .font(.system(size: 64))
                        .bold()
                    HStack(spacing: 20) {
                        VStack {
                            Text("濕度")
                            Text("60%")
                        }
                        VStack {
                            Text("風速")
                            Text("10 km/h")
                        }
                        VStack {
                            Text("降雨率")
                            Text("10%")
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(forecastDays) { day in
                            VStack {
                                Text(day.date)
                                Image(systemName: day.iconName)
                                    .font(.title)
                                Text("\(day.maxTemp)° / \(day.minTemp)°")
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                        }
                    }
                    .padding(.horizontal)
                }
                Spacer()
            }
            .navigationTitle("天氣")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("信標按鈕點擊")
                    } label: {
                        Image(systemName: "location.fill")
                            .foregroundColor(Color(uiColor: .label))
                    }
                }
            }
        }
    }
}

#Preview {
    WeatherHomeView()
}
