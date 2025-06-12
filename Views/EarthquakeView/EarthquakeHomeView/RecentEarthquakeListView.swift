//
//  RecentEarthquakeListView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI

struct RecentEarthquakeListView: View {
    @ObservedObject var eqViewModel: EarthquakeViewModel

    var body: some View {
        List {
            Section(header: Text("近期地震").font(.headline)) {
                ForEach(Array(eqViewModel.earthquakes.prefix(10))) { quake in
                    NavigationLink(destination: EarthquakeDetailView(earthquake: quake)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(quake.earthquakeInfo.originTime)")
                            Text("\(quake.earthquakeInfo.epicenter.location)")
                                .font(.subheadline)
                            HStack {
                                Text("規模 \(quake.earthquakeInfo.earthquakeMagnitude.magnitudeValue, specifier: "%.1f")")
                                Text("最大震度 \(quake.intensity.shakingArea.first?.areaIntensity ?? "-")")
                            }
                            .font(.caption)
                            .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RecentEarthquakeListView(eqViewModel: EarthquakeViewModel())
}
