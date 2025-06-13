//
//  ContentView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI

struct EarthquakeHomeView: View {
    
    //@StateObject private var eqViewModel = EarthquakeViewModel(service: StubEarthquakeService()) // Test
    @StateObject private var eqViewModel = EarthquakeViewModel()
    @State private var showAlarmAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                if let eq = eqViewModel.latestStrongIntensityEarthquake {
                    NavigationLink(destination: EmergencyHelpView()) {
                        EarthquakeCardView(earthquake: eq)
                    }
                }
                RecentEarthquakeListView(eqViewModel: eqViewModel)
            }
            .navigationTitle("地震警報")
            .background(Color(.systemGroupedBackground))
            .onAppear { eqViewModel.fetchEarthquakeReport() }
            .onChange(of: eqViewModel.isAlarmActive) { newValue in
                if newValue {
                    showAlarmAlert = true
                }
            }
            .alert("警報！有感地震", isPresented: $showAlarmAlert) {
                Button("確定") {
                    showAlarmAlert = false
                    eqViewModel.isAlarmActive = false
                }
            }
        }
    }
}


#Preview {
    EarthquakeHomeView()
}
