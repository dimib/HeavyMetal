//
//  MetalKitViewModel.swift
//  HeavyMetal
//
//  Created by Dimitrios Brukakis on 30.08.24.
//

import Foundation
import MetalKit

final class MetalKitViewModel: NSObject {
    private(set) var device = MTLCreateSystemDefaultDevice()
    private var commandQueue: MTLCommandQueue?
    private var texture: MTLTexture?
    private var pipelineState: MTLRenderPipelineState?

    override init() {
        super.init()
        
        self.commandQueue = device?.makeCommandQueue()
        loadTexture()
    
        self.pipelineState = buildPipelineState()
    }
    
    private func buildPipelineState() -> MTLRenderPipelineState? {
        guard let device,
              let library = device.makeDefaultLibrary()
        else { return nil }
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.vertexFunction = library.makeFunction(name: "vertex_shader")
        pipelineDescriptor.fragmentFunction = library.makeFunction(name: "fragment_shader")
        pipelineDescriptor.depthAttachmentPixelFormat = .invalid
        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm_srgb

        let vertexDescriptor = MTLVertexDescriptor()
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = MemoryLayout<SIMD3<Float>>.stride
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.layouts[0].stride = MemoryLayout<TexturedVertex>.stride
        pipelineDescriptor.vertexDescriptor = vertexDescriptor
        
        do {
            return try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func loadTexture() {
        guard let device,
        let url = Bundle.main.url(forResource: "AppleLogo", withExtension: "png") else {
            return
        }
        let textureLoaderOptions: [MTKTextureLoader.Option : Any] = [
            .textureUsage: NSNumber(value: MTLTextureUsage.shaderRead.rawValue | MTLTextureUsage.renderTarget.rawValue),
            .textureStorageMode: NSNumber(value: MTLStorageMode.shared.rawValue)
        ]
        let textureLoader = MTKTextureLoader(device: device)
        do {
            let texture = try textureLoader.newTexture(URL: url, options: textureLoaderOptions)
            self.texture = texture
        } catch {
            debugPrint("🤘 error=\(error)")
        }
    }
}

extension MetalKitViewModel:MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        //
    }
    
    func draw(in view: MTKView) {

        guard let drawable = view.currentDrawable,
              let pipelineState,
              let texture else { return
        }


        let commandBuffer = commandQueue?.makeCommandBuffer()
        let descriptor = MTLRenderPassDescriptor()
        descriptor.colorAttachments[0].texture = texture
        descriptor.colorAttachments[0].loadAction = .clear
        descriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)
        descriptor.colorAttachments[0].storeAction = .store
        
        guard let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor) else { return }
        
        // Hier fügst du den Code hinzu, um die Textur zu rendern
        // Füge deine Metal-Pipeline, Vertex-Buffer und Shader-Setup hier ein
        let vertices = [
            TexturedVertex(position: SIMD3(x: -1, y: 1, z: 0), texture: SIMD2(x: 0, y: 0)),
            TexturedVertex(position: SIMD3(x: 1, y: 1, z: 0), texture: SIMD2(x: 1, y: 0)),
            TexturedVertex(position: SIMD3(x: 1, y: -1, z: 0), texture: SIMD2(x: 1, y: 1)),
            TexturedVertex(position: SIMD3(x: -1, y: -1, z: 0), texture: SIMD2(x: 0, y: 1)),
            TexturedVertex(position: SIMD3(x: -1, y: 1, z: 0), texture: SIMD2(x: 0, y: 0))
        ]
        let vertexBuffer = device?.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<TexturedVertex>.stride)
        
        renderEncoder.setRenderPipelineState(pipelineState)
//        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderEncoder.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
