//
//  HardRockDemoView.swift
//  HeavyMetal
//
//  Created by Dimitri Brukakis on 30.08.24.
//

import SwiftUI

struct HardRockDemoContentView: View {
    var body: some View {
        VStack {
            
            MetalKitViewRepresentable()
                .frame(width: 300, height: 300)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HardRockDemoContentView()
}
