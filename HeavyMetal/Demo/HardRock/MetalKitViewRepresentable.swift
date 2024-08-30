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


    func updateUIView(_ uiView: MTKView, context: Context) {
        return MTKView(frame: .zero, device: <#T##(any MTLDevice)?#>)
    }
    
    
    func makeUIView(context: Context) -> MTKView {
        <#code#>
    }

}
