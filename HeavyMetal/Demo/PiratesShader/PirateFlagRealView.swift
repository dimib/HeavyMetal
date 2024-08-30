//
//  PirateFlagRealView.swift
//  HeavyMetal
//
//  Created by Dimitrios Brukakis on 30.08.24.
//

import SwiftUI

struct PirateFlagRealView: View {
    let time: TimeInterval

    var body: some View {
        VStack {
            Image("PirateFlag")
                .resizable()
                .colorEffect(ShaderLibrary.rainbowFlag(.float(time)))
                .padding(.vertical, 50)
                .background(.white)
                .drawingGroup()
                .frame(width: 200, height: 200)
                .visualEffect { content, geometryProxy in
                    content
                        .distortionEffect(ShaderLibrary.waveFlagReal(.float(time),
                                                                     .float2(geometryProxy.size)),
                                          maxSampleOffset: .zero)

                }
        }
    }
}

#Preview {
    PirateFlagRealView(time: 0)
}
