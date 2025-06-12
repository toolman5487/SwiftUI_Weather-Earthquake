//
//  ContentView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI

struct EarthquakeHomeView: View {
    
    @StateObject private var eqViewModel = EarthquakeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                if let eq = eqViewModel.latestMagnitudeAboveThree {
                    NavigationLink(destination: EmergencyHelpView()) {
                        EarthquakeCardView(earthquake: eq)
                    }
                }
                
                RecentEarthquakeListView(eqViewModel: eqViewModel)
            }
            .navigationTitle("地震警報")
            .background(Color(.systemGroupedBackground))
            .onAppear { eqViewModel.fetchEarthquakeReport() }
        }
    }
}


#Preview {
    EarthquakeHomeView()
}
