//
//  CalculationDemo.metal
//  HeavyMetal
//
//  Created by Dimitri Brukakis on 28.08.24.
//

#include <metal_stdlib>
using namespace metal;

kernel void metal_array_log(device const float* in,
                            device float* result,
                            uint index [[thread_position_in_grid]]) {
    result[index] = in[index] * 2; //sin(in[index]);
}

kernel void metal_array_sin(device const float* in,
                            device float* result,
                            uint index [[thread_position_in_grid]]) {
    result[index] = sin(in[index]);
}
