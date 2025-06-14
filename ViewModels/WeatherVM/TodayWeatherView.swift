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
                
                Image(systemName: systemImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                
                Text(weatherDescription)
                    .font(.title2)
                    .foregroundColor(.secondary)
            } else {
                Text("無今日天氣資料")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

#Preview {
    TodayWeatherView(location: .init(locationName: "台北市", weatherElement: []))
}
