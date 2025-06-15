//
//  ContentView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI

struct EarthquakeHomeView: View {
    
    //    @StateObject var earthquakeMockVM = EarthquakeViewModel()
    @StateObject private var eqViewModel = EarthquakeViewModel()
    @State private var showAlarmAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                //                if let eq = earthquakeMockVM.latestStrongIntensityEarthquake {
                if let eq = eqViewModel.latestStrongIntensityEarthquake {
                    NavigationLink(destination: EmergencyHelpView()) {
                        EarthquakeCardView(earthquake: eq)
                    }
                }
                RecentEarthquakeListView(eqViewModel: eqViewModel)
                //                RecentEarthquakeListView(eqViewModel: earthquakeMockVM) // MockData
            }
            .navigationTitle("地震警報")
            .background(Color(.systemGroupedBackground))
            .onAppear {
                eqViewModel.fetchEarthquakeReport()
                
                //                // 改用 mock VM 載入模擬資料
                //                earthquakeMockVM.earthquakes = [MockEarthquakeData.mockEarthquake]
                //                earthquakeMockVM.updateLatestWithMock()
            }
//            .onChange(of: earthquakeMockVM.isAlarmActive) { newValue in
            .onChange(of: eqViewModel.isAlarmActive) { newValue in
                if newValue {
                    showAlarmAlert = true
                }
            }
            .alert("警報！有感地震", isPresented: $showAlarmAlert) {
                Button("確定") {
                    showAlarmAlert = false
                    eqViewModel.isAlarmActive = false
//                    earthquakeMockVM.isAlarmActive = false
                }
            }
        }
    }
}


#Preview {
    EarthquakeHomeView()
}
