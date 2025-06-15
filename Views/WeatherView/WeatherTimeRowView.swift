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
        
        VStack{
            Text("\(timeEntry.startTime) ~ \(timeEntry.endTime)")
                .frame(alignment: .leading)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.vertical)
            
            HStack{
                VStack{
                    HStack {
                        Image(systemName: imageName)
                            .frame(width: 36,height: 36)
                        Text(weatherName)
                            .lineLimit(1)
                            .minimumScaleFactor(0.3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                }
                .padding()
                
                Spacer()
                VStack{
                    if let minTemp = minTemp, let maxTemp = maxTemp {
                        Text("最低 \(minTemp)℃")
                        Spacer()
                        Text("最高 \(maxTemp)℃")
                    }
                }
                .padding(.vertical)
            }
        }
    }
}
