//
//  LayerShaderDemo.metal
//  HeavyMetal
//
//  Created by Dimitrios Brukakis on 01.09.24.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] half4 ghostShader(float2 position, SwiftUI::Layer layer, float distance, float intensity) {
    half4 color = layer.sample(position);
    half4 other_color = layer.sample(float2(position.x + distance, position.y));
    if (other_color.a == 0) { return color; }

    other_color.a *= intensity;
    half4 new_color = other_color;

    return new_color;
}
