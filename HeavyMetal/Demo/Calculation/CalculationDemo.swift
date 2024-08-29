//
//  CalculationDemo.swift
//  HeavyMetal
//
//  Created by Dimitri Brukakis on 28.08.24.
//

import Foundation
import MetalKit

final class CalculationDemo {
    
    let dispatchQueue = DispatchQueue(label: "calc", qos: .userInitiated)
    
    private var array = [Float]()
    private var result1 = [Float]()
    private var result2 = [Float]()
    
    // MARK: - Run on CPU
    func calculateWithCpu(completion: @escaping (String) -> Void) {
        
        dispatchQueue.asyncAfter(deadline: .now() + 1) {
            debugPrint("Start")
            let start = Date().timeIntervalSince1970
            for index in 0..<self.array.count {
                self.result1[index] = self.array[index] * 2// sin(self.array[index])
            }
            let finish = Date().timeIntervalSince1970
            debugPrint("Finish")
            completion("Done: \(TimeInterval(finish - start))")
        }
    }

    // MARK: - Run on GPU
    
    var device = MTLCreateSystemDefaultDevice()

    func calculateWithGpu(completion: @escaping (String) -> Void) {

        guard let defaultLibrary = device?.makeDefaultLibrary(),
              let metalArrayLog = defaultLibrary.makeFunction(name: "metal_array_log"),
              let pipelineState = try? device?.makeComputePipelineState(function: metalArrayLog) as? MTLComputePipelineState
        else { return completion("Error") }

        debugPrint("Start")
        let start = Date().timeIntervalSince1970

        let commandQueue = device?.makeCommandQueue()
        let buffer = device?.makeBuffer(bytes: self.array, length: self.array.count * MemoryLayout<Float>.stride,
                                        options: []);
        let resultBuffer = device?.makeBuffer(bytes: self.result2, length: self.array.count * MemoryLayout<Float>.stride,
                                              options: []);
        let commandBuffer = commandQueue?.makeCommandBuffer()
        let computeEncoder = commandBuffer?.makeComputeCommandEncoder()
        
        computeEncoder?.setComputePipelineState(pipelineState)
        computeEncoder?.setBuffer(buffer, offset: 0, index: 0)
        computeEncoder?.setBuffer(resultBuffer, offset: 0, index: 1)
        
        let gridSize = MTLSizeMake(self.array.count, 1, 1)
        var threadGroupSize = pipelineState.maxTotalThreadsPerThreadgroup
        if threadGroupSize > array.count {
            threadGroupSize = array.count
        }
        computeEncoder?.dispatchThreads(gridSize, threadsPerThreadgroup: MTLSizeMake(threadGroupSize, 1, 1))
        computeEncoder?.endEncoding()
        commandBuffer?.commit()
        
        commandBuffer?.waitUntilCompleted()

        withUnsafeMutablePointer(to: &result2) { buffer in
            if let contents = resultBuffer?.contents(), let length = resultBuffer?.length {
                memcpy(&buffer.pointee, contents, length)
            }
        }

        let finish = Date().timeIntervalSince1970
        debugPrint("Finish")
        completion("Done: \(TimeInterval(finish - start))")
    }
    
    // MARK: - Helper
    
    func makeArrays(numberOfValues: Int, completion: @escaping (String) -> Void) {
        dispatchQueue.async {
            self.array = self.makeArray(numberOfValues: numberOfValues)
            self.result1 = self.makeEmptyArray(numberOfValues: numberOfValues)
            self.result2 = self.makeEmptyArray(numberOfValues: numberOfValues)
            completion("Done")
        }
    }
    
    private func makeArray(numberOfValues: Int) -> [Float] {
        let array = [Float](unsafeUninitializedCapacity: numberOfValues) { buffer, initializedCount in
            for value in 0..<numberOfValues {
                buffer[value] = (Float(value))
            }
            initializedCount = numberOfValues
        }
        return array
    }
    
    private func makeEmptyArray(numberOfValues: Int) -> [Float] {
        let array = [Float](unsafeUninitializedCapacity: numberOfValues) { buffer, initializedCount in
            for value in 0..<numberOfValues {
                buffer[value] = 0
            }

            initializedCount = numberOfValues
        }
        return array
    }
    
    // MARK: - Compare
    func compare() -> Int {
        let count = array.count
        var diff = 0
        
        for index in 0..<count {
            if result1[index] != result2[index] {
                diff += 1
            }
        }
        
        return diff
    }
}

struct DoubleValue {
    let value: Double
    var sinus: Double
}
