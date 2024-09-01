//
//  LayerShaderContentView.swift
//  HeavyMetal
//
//  Created by Dimitrios Brukakis on 01.09.24.
//

import SwiftUI

struct LayerShaderContentView: View {

    @State var distance: CGFloat = 0
    @State var intensity: CGFloat = 1

    var body: some View {
        VStack {
            VStack(spacing: 24) {
                Image("AppleLogo")
                    .resizable()
                    .scaledToFit()
                    .drawingGroup()
                    .padding(.vertical, 80)
                    .layerEffect(ShaderLibrary.ghostShader(.float(distance), .float(intensity)),
                                 maxSampleOffset: .zero)
                VStack {
                    Text("Distance: \(Int(distance))")
                    Slider(value: $distance, in: 0...24)
                }
                VStack {
                    Text("Intensity: \(intensity)")
                    Slider(value: $intensity, in: 0...1)
                }
            }
            .padding(50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    LayerShaderContentView()
}
