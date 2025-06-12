//
//  EmergencyHelpView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI
import CoreLocation
import MapKit

struct EmergencyHelpView: View {
    
    @State private var isBouncing = false
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 23.5, longitude: 121.0),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    private func updateRegion(_ coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            region.center = coord
        }
    }
    
    var body: some View {
        VStack {
            if let location = locationManager.currentLocation {
                Map(coordinateRegion: $region,
                    annotationItems: [location]) { coord in
                    MapMarker(coordinate: coord, tint: .red)
                }
                    .frame(width: .infinity, height: 220)
                    .cornerRadius(18)
                    .padding()
                    .onAppear { updateRegion(location) }
                    .onChange(of: location) { updateRegion($0) }
            } else {
                Image(systemName: "location.slash.circle")
                    .font(.system(size:60))
                    .foregroundColor(.secondary)
                    .frame(width: 60, height: 60)
                    .offset(x: isBouncing ? -2 : 0)
                    .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isBouncing)
                    .onAppear { isBouncing = true }
            }
            
            List {
                Section(header: Text("求助電話")) {
                    HelpButton(title: "119 救護", number: "119", color: .red)
                    HelpButton(title: "110 報警", number: "110", color: .blue)
                    HelpButton(title: "112 國際", number: "112", color: .orange)
                }
            }
            
            Button(action: { locationManager.requestLocation() }) {
                VStack{
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 100, height: 100)
                            .shadow(color: Color.red.opacity(0.25), radius: 8, x: 0, y: 3)
                        Image(systemName: "location.fill")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle("緊急協助")
    }
}


#Preview {
    EmergencyHelpView()
}


