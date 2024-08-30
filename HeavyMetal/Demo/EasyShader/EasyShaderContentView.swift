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
           Image("AppleLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .colorEffect(ShaderLibrary.gradientFill())

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    EasyShaderContentView()
}
