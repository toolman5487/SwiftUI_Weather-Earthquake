//
//  ContentView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI

struct EarthquakeHomeView: View {
    
    @StateObject private var eqViewModel = EarthquakeViewModel(service: StubEarthquakeService())
    //     @StateObject private var eqViewModel = EarthquakeViewModel()
    @State private var showAlarmAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if let eq = eqViewModel.latestStrongIntensityEarthquake {
                    NavigationLink(destination: EmergencyHelpView()) {
                        EarthquakeCardView(earthquake: eq)
                    }
                }else {
                    HStack(spacing: 16) {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.green)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("速報")
                                .font(.title).bold()
                                .foregroundColor(.primary)
                            Text("目前無有感地震")
                                .font(.headline)
                            Text("目前一切安全")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(Color(UIColor.secondarySystemBackground))
                            .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
                    )
                    .padding(.horizontal)
                    .frame(minHeight: 100)
                }
                RecentEarthquakeListView(eqViewModel: eqViewModel)
            }
            .navigationTitle("地震警報")
            .background(Color(.systemGroupedBackground))
            .onAppear {
                eqViewModel.fetchEarthquakeReport()
            }
            
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
