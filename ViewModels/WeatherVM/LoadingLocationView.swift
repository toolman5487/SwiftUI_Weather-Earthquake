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
        Group {
            Image(systemName: "location.viewfinder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .animation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: true),
                    value: shake
                )
                .onAppear {
                    shake = true
                }
            MakeAnimationView(animationName: "loadingPoint")
                .frame(maxWidth: .infinity, maxHeight: 60)
        }
    }
}

#Preview {
    LoadingLocationView()
}
