//
//  Types.swift
//  HeavyMetal
//
//  Created by Dimitri Brukakis on 30.08.24.
//

import Foundation
import MetalKit
import simd

struct ColoredVertex {
    let position: SIMD3<Float>
    let color: SIMD4<Float>
}

struct TexturedVertex {
    let position: SIMD3<Float>
    let texture: SIMD2<Float>
}
