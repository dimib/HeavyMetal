//
//  PiratesShaderDemo.metal
//  HeavyMetal
//
//  Created by Dimitrios Brukakis on 29.08.24.
//

#include <metal_stdlib>
using namespace metal;

[[stitchable]] float2 waveFlag(float2 pos, float t) {
    float offset = 10;
    pos.y += sin(t * offset + pos.x / 20) * offset;
    return pos;
}

[[stitchable]] half4 rainbowFlag(float2 pos, half4 color, float time) {
    if (color.r == 0 && color.g == 0 && color.b == 0) {
        return color;
    }
    float angle = atan2(pos.y, pos.x) + time;
    return half4(sin(angle), sin(angle + 2), sin(angle +4), color.a);
}

[[stitchable]] float2 waveFlagReal(float2 pos, float t, float2 size) {
    float offset = 5;

    float2 distance = pos / size;

    pos.y += sin(t * offset + pos.x / 20) * (distance.x * offset);
    return pos;
}

