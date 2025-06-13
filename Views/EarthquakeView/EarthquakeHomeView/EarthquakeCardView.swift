//
//  EarthquakeCardView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/12.
//

import SwiftUI

struct EarthquakeCardView: View {
    
    let earthquake: Earthquake
    var maxIntensityArea: ShakingArea? {
        earthquake.intensity.shakingArea.max { area1, area2 in
            let intensity1 = Int(area1.areaIntensity.replacingOccurrences(of: "級", with: "")) ?? 0
            let intensity2 = Int(area2.areaIntensity.replacingOccurrences(of: "級", with: "")) ?? 0
            return intensity1 < intensity2
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.red)
            VStack(alignment: .leading, spacing: 6) {
                Text("速報")
                    .font(.title).bold()
                    .foregroundColor(.primary)
                Text("\(earthquake.earthquakeInfo.originTime)")
                
                Text("\(earthquake.earthquakeInfo.epicenter.location)")
                    .frame(alignment: .leading)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                HStack {
                    Text("規模 \(earthquake.earthquakeInfo.earthquakeMagnitude.magnitudeValue, specifier: "%.1f")")
                    Text("最大震度 \(maxIntensityArea?.areaIntensity ?? "-")")
                }
                .font(.headline)
                .foregroundColor(.red)
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
    }
}
#Preview {
    EarthquakeCardView(earthquake: Earthquake.mock)
}
