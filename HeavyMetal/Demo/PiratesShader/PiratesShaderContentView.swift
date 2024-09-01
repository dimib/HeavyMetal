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

                PirateFlagSimpleView(time: time)

//                PirateFlagRealView(time: time)

                Spacer().frame(height: 40)

                Text("Arrrrr! And a bottle of rum!")
                    .padding(.vertical, 20)
                    .background(.white)
                    .drawingGroup()
                    .frame(height: 80)
                    .distortionEffect(ShaderLibrary.waveFlag(.float(time)),
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
