//
//  LoadingLocationView.swift
//  SwiftUIProject02
//
//  Created by Willy Hsu on 2025/6/14.
//

import SwiftUI

struct LoadingLocationView: View {
    @State private var shake = false
    var body: some View {
        VStack(spacing: 8) {
            Text("請開啟定位以取得當前城市天氣")
                .foregroundColor(.secondary)
                .font(.headline)
            Image(systemName: "location.viewfinder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .animation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: true),
                    value: shake
                )
                .onAppear {
                    shake = true
                }
            MakeAnimationView(animationName: "loadingPoint")
                .frame(maxWidth: .infinity, maxHeight: 100)
        }
    }
}

#Preview {
    LoadingLocationView()
}
