//
//  EasyShaderDemo.metal
//  HeavyMetal
//
//  Created by Dimitrios Brukakis on 29.08.24.
//

#include <metal_stdlib>
using namespace metal;


[[stitchable]] half4 passthrough(float2 pos, half4 color) {
    return color;
}


[[stitchable]] half4 recolor(float2 pos, half4 color) {
    return half4(color.r / 2, 255, 0, color.a);
}

[[stitchable]] half4 invertAlpha(float2 pos, half4 color) {
    return half4(color.r, color.g, color.b, 1 - color.a);
}

[[stitchable]] half4 gradientFill(float2 pos, half4 color) {
    if (color.a == 0) { return color; }
    return half4(pos.x / pos.y, 0, pos.y / pos.x, color.a);
}
