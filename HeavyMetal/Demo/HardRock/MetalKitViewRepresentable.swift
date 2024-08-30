//
//  MetalKitViewRepresentable.swift
//  HeavyMetal
//
//  Created by Dimitrios Brukakis on 30.08.24.
//

import Foundation
import MetalKit
import SwiftUI

struct MetalKitViewRepresentable: UIViewRepresentable {

    @State var viewModel = MetalKitViewModel()
    
    
    func updateUIView(_ uiView: MTKView, context: Context) {
    }
    
    
    func makeUIView(context: Context) -> MTKView {
        let view = MTKView(frame: .zero)
        view.device = viewModel.device
        view.delegate = viewModel
        return view
    }
}
