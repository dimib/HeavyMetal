//
//  InfernoBlurContentView.swift
//  HeavyMetal
//
//  Created by Dimitrios Brukakis on 01.09.24.
//

import SwiftUI
import Inferno

struct InfernoContentView: View {

    @State var blurRadius: CGFloat = 0
    @State var checkersize: CGFloat = 10
    var body: some View {
        VStack {
            VStack(spacing: 24) {
                VStack {
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...")
                        .font(.title)
                        .variableBlur(radius: blurRadius, mask: Image("PirateFlag"))

                    Slider(value: $blurRadius, in: 0...20)

                }
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...")
                    .font(.body)

                Button(action: {
                    checkersize += 2
                    if (checkersize > 20) { checkersize = 10 }

                }) {
                    VStack {
                        Text("Helloooo!!1elf!!")
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 200, height: 50)
                    .background(
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 10))
                            .foregroundColor(.blue)
                            .colorEffect(InfernoShaderLibrary.checkerboard(
                                        .color(Color.red),
                                        .float(checkersize))
                            )
                    )
                }

            }
            .padding(.horizontal, 24)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}



#Preview {
    InfernoContentView()
}
