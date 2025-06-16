//
//  WeatherTimeRowView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/15.
//

import SwiftUI

struct WeatherTimeRowView: View {
    
    let timeEntry: Time
    let minTemp: String?
    let maxTemp: String?
    
    var body: some View {
        let weatherName = timeEntry.parameter.parameterName
        let imageName = weatherName.weatherSystemImageName()
        
        HStack{
            VStack{
                Text("\(timeEntry.startTime)")
                Text("|")
                Text("\(timeEntry.endTime)")
            }
            .frame(alignment: .leading)
            .font(.caption)
            .foregroundColor(.secondary)
            .padding()
            
            VStack{
                Image(systemName: imageName)
                    .frame(width: 36,height: 36)
                Text(weatherName)
                    .lineLimit(1)
                    .minimumScaleFactor(0.3)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            
            VStack(spacing: 12){
                if let minTemp = minTemp, let maxTemp = maxTemp {
                    Text("最高 \(maxTemp)℃")
                    Text("最低 \(minTemp)℃")
                }
            }
            .padding(.vertical)
        }
        
    }
}
