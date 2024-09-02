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

    @State var dragLocation: CGPoint = .zero
    @State var dragVelocity: CGSize = .zero

    var body: some View {
        VStack {
            VStack(spacing: 24) {
//                Image("AppleLogo")
//                    .resizable()
//                    .scaledToFit()
//                    .drawingGroup()
//                    .padding(.vertical, 80)
//                    .layerEffect(ShaderLibrary.w(.float2(dragLocation), .float2(dragVelocity)),
//                                 maxSampleOffset: .zero)
//                VStack {
//                    Text("Distance: \(Int(distance))")
//                    Slider(value: $distance, in: 0...24)
//                }
//                VStack {
//                    Text("Intensity: \(intensity)")
//                    Slider(value: $intensity, in: 0...1)
//                }

                Text("Lorem ipsum dolor sit amet, cons ectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...")
                    .lineLimit(100)
                    .font(.title)
                    .foregroundStyle(Color.white)
                    .layerEffect(ShaderLibrary.w(.float2(dragLocation), .float2(dragVelocity)),
                                 maxSampleOffset: .zero)
            }
            .padding(50)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.black)
        .gesture(DragGesture()
            .onChanged({ value in
                dragVelocity = value.velocity
                dragLocation = value.location
            })
        )
    }
}

#Preview {
    LayerShaderContentView()
}
