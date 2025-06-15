//
//  WeatherTimeRowView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/15.
//

import SwiftUI

struct WeatherTimeRowView: View {
    let timeEntry: Time
    
    var body: some View {
        let weatherName = timeEntry.parameter.parameterName
        let imageName = weatherName.weatherSystemImageName()
        
        VStack(alignment: .leading) {
            Text("\(timeEntry.startTime) ~ \(timeEntry.endTime)")
                .font(.caption)
                .foregroundColor(.secondary)
            HStack {
                Image(systemName: imageName)
                    .frame(width: 30, height: 30)
                Text(weatherName)
            }
        }
        .padding(.vertical, 4)
    }
}
