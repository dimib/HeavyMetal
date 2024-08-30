//
//  PiratesShaderContentView.swift
//  HeavyMetal
//
//  Created by Dimitrios Brukakis on 29.08.24.
//

import SwiftUI

struct PiratesShaderContentView: View {
    @State var start = Date()

    var body: some View {
        VStack(spacing: 20) {
            TimelineView(.animation) { tl in
                let time = start.distance(to: tl.date) / 3
//                Rectangle()
//                    .padding(.vertical, 30)
//                    .background(.white)
//                    .drawingGroup()
//                    .frame(width: 200, height: 100)
//                        .distortionEffect(ShaderLibrary.waveFlag(.float(time), .float2(0, 0)),
//                                          maxSampleOffset: .zero)

                Image("PirateFlag")
                    .resizable()
                    .colorEffect(ShaderLibrary.rainbowFlag(.float(time)))
                    .padding(.vertical, 50)
                    .background(.white)
                    .drawingGroup()
                    .frame(width: 200, height: 200)
                    .distortionEffect(ShaderLibrary.waveFlag(.float(time), .float2(0, 0)),
                                      maxSampleOffset: .zero)

                Spacer().frame(height: 40)
                Text("Arrrrr! And a bottle of rum!")
                    .padding(.vertical, 20)
                    .background(.white)
                    .drawingGroup()
                    .distortionEffect(ShaderLibrary.waveFlag(.float(time), .float2(0, 0)),
                                      maxSampleOffset: .zero)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    PiratesShaderContentView()
}
