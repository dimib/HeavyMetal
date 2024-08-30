//
//  PirateFlagSimpleView.swift
//  HeavyMetal
//
//  Created by Dimitrios Brukakis on 30.08.24.
//

import SwiftUI

struct PirateFlagSimpleView: View {
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
                .distortionEffect(ShaderLibrary.waveFlag(.float(time)),
                                  maxSampleOffset: .zero)
        }
    }
}

#Preview {
    PirateFlagSimpleView(time: 0)
}
