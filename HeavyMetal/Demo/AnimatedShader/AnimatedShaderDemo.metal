//
//  AnimatedShader.metal
//  HeavyMetal
//
//  Created by Dimitrios Brukakis on 29.08.24.
//

#include <metal_stdlib>
using namespace metal;

[[stitchable]] half4 rainbow(float2 pos, half4 color, float time) {
    if (color.a == 0) { return color; }

    float angle = atan2(pos.y, pos.x) + time;

    return half4(sin(angle), sin(angle + 2), sin(angle +4), color.a);
}

[[stitchable]] float2 wave(float2 pos, float time, float offset) {
    pos.y += sin(time * offset + pos.y / 20) * offset;
    return pos;
}
