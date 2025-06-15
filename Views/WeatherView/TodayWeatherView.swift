//
//  TodayWeatherView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/14.
//

import SwiftUI

struct TodayWeatherView: View {
    let location: Location
    
    var body: some View {
        VStack(spacing: 10) {
            Text(location.locationName)
                .font(.largeTitle)
                .fontWeight(.bold)
            if let wx = location.weatherElement.first(where: { $0.elementName == "Wx" }),
               let time = wx.currentTimeEntry() ?? wx.time.first {
                let weatherDescription = time.parameter.parameterName
                let systemImageName = weatherDescription.weatherSystemImageName()
                
                let minT = location.weatherElement.first(where: { $0.elementName == "MinT" })?.time.first(where: { $0.startTime == time.startTime })?.parameter.parameterName
                let maxT = location.weatherElement.first(where: { $0.elementName == "MaxT" })?.time.first(where: { $0.startTime == time.startTime })?.parameter.parameterName
                
                Image(systemName: systemImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                
                Text(weatherDescription)
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 12) {
                    if let minT = minT {
                        Text("最低溫: \(minT)°C")
                    }
    
                    if let maxT = maxT {
                        Text("最高溫: \(maxT)°C")
                    }
                }
                .font(.headline)
            } else {
                Text("無今日天氣資料")
            }
        }
        .padding()
    }
}

#Preview {
    TodayWeatherView(location: .init(locationName: "台北市", weatherElement: []))
}
