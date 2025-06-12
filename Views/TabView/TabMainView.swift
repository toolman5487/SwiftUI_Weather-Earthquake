//
//  TabMainView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI

struct TabMainView: View {
    var body: some View {
        TabView {
            EarthquakeHomeView()
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                    Text("地震")
                }
            WeatherView()
                .tabItem {
                    Image(systemName: "cloud.sun.fill")
                    Text("天氣")
                }
        }
    }
}

#Preview {
    TabMainView()
}
