//
//  AnimatedShaderContentView.swift
//  HeavyMetal
//

import SwiftUI

struct AnimatedShaderContentView: View {

    @State var start = Date()

    var body: some View {
        VStack {
            TimelineView(.animation) { tl in
                let time = start.distance(to: tl.date)
                Image("AppleLogo")
                     .resizable()
                     .scaledToFit()
                     .colorEffect(ShaderLibrary.rainbow(.float(time)))
                     .distortionEffect(ShaderLibrary.wave(.float(time), .float(4)),
                                       maxSampleOffset: .zero)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

    }
}

#Preview {
    AnimatedShaderContentView()
}
