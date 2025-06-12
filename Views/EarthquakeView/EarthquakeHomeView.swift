//
//  ContentView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI

struct EarthquakeHomeView: View {
    let latestEarthquake = (
        location: "台中市",
        magnitude: "5.8",
        intensity: "6級",
        date: "2025/06/12 11:02"
    )
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                HStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.red)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("地震速報")
                            .font(.title).bold()
                            .foregroundColor(.primary)
                        Text("\(latestEarthquake.date)  \(latestEarthquake.location)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        HStack {
                            Text("規模 \(latestEarthquake.magnitude)")
                            Text("最大震度 \(latestEarthquake.intensity)")
                        }
                        .font(.headline)
                        .foregroundColor(.red)
                    }
                Spacer()
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
                )
                .padding(.horizontal)
                
                List {
                    Section(header: Text("近期地震").font(.headline)) {
                        ForEach(0..<10) { i in
                            HStack {
                                Image(systemName: "bolt.fill")
                                    .foregroundColor(.orange)
                                VStack(alignment: .leading) {
                                    Text("2025/06/11 高雄市")
                                    Text("規模 5.2  最大震度 5級")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 3)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("地震警報")
            .background(Color(.systemGroupedBackground))
        }
    }
}


#Preview {
    EarthquakeHomeView()
}
