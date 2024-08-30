//
//  HardRockDemo.metal
//  HeavyMetal
//
//  Created by Dimitri Brukakis on 30.08.24.
//

#include <metal_stdlib>
using namespace metal;

struct Constants {
    float animateBy;
};

struct VertexIn {
    float4 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};

struct VertexOut {
    float4 position [[ position ]];
    float4 color;
};

vertex VertexOut vertex_shader(const VertexIn vertexIn [[ stage_in ]],
                               constant Constants &constants [[ buffer(1) ]]) {
    VertexOut vertexOut;
    vertexOut.position = vertexIn.position;
    vertexOut.position.y += constants.animateBy;
    vertexOut.color = vertexIn.color;
    return vertexOut;
}

fragment half4 fragment_shader(const VertexOut vertexIn [[ stage_in ]]) {
    return half4(vertexIn.color);
}
