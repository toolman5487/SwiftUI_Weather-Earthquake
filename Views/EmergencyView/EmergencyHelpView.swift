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
                    .frame(width: .infinity, height: 240)
                    .cornerRadius(18)
                    .padding()
                    .onAppear { updateRegion(location) }
                    .onChange(of: location) { updateRegion($0) }
            } else {
                Image(systemName: "wave.3.up")
                    .font(.system(size: 120))
                    .padding()
                    .frame(width: .infinity, height: 240)
                    .foregroundColor(.secondary)
            }
            
            List {
                Section(header: Text("求助電話")) {
                    HelpButton(title: "119 救護", number: "119", color: .red)
                    HelpButton(title: "110 報警", number: "110", color: .blue)
                    HelpButton(title: "112 國際", number: "112", color: .orange)
                }
            }
            
            Button(action: { locationManager.requestLocation() }) {
                Text("重新定位")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(22)
                    .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 40)
            
            Spacer()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("緊急協助")
    }
}


#Preview {
    EmergencyHelpView()
}
