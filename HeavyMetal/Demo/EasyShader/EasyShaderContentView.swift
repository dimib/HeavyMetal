//
//  EasyShaderContentView.swift
//  HeavyMetal
//
//  Created by Dimitrios Brukakis on 29.08.24.
//

import SwiftUI

struct EasyShaderContentView: View {
    var body: some View {
        VStack {
           Image("AppleLogoBlack")
                .resizable()
                .scaledToFit()
                .colorEffect(ShaderLibrary.passthrough())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    EasyShaderContentView()
}
