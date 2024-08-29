//
//  CalculationContentView.swift
//  HeavyMetal
//
//  Created by Dimitri Brukakis on 28.08.24.
//

import SwiftUI

struct CalculationContentView: View {
    
    let calculationDemo = CalculationDemo()
    
    @State private var numberOfValues = 1_000_000.0
    
    @State private var makeArrayStatus: String = "..."
    @State private var durationWithCpu: String = "..."
    @State private var durationWithGpu: String = "..."
    @State private var compareResult: String = "..."
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Calculate with a large amount of numbers.")
                .font(.title)

            Text("Numbers: \(Int(numberOfValues))")
            Slider(value: $numberOfValues, in: 100...32_000_000) {
                Text("Numers: \(numberOfValues)")
            }
            
            HStack {
                Button(action: makeArrays) {
                    Text("Make Array")
                }
                Spacer()
                Text("\(makeArrayStatus)")
            }
            
            HStack {
                Button(action: calculateWithCpu) {
                    Text("Use CPU")
                }
                Spacer()
                Text("\(durationWithCpu)")
            }

            HStack {
                Button(action: calculateWithGpu) {
                    Text("Use GPU")
                }
                Spacer()
                Text("\(durationWithGpu)")
            }
            HStack {
                Button(action: compare) {
                    Text("Compare")
                }
                Spacer()
                Text("\(compareResult)")
            }

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    func makeArrays() {
        makeArrayStatus = "Wait..."
        calculationDemo.makeArrays(numberOfValues: Int(numberOfValues)) { status in
            makeArrayStatus = status
        }
    }
    
    func calculateWithCpu() {
        durationWithCpu = "Wait..."
        calculationDemo.calculateWithCpu() { duration in
            durationWithCpu = duration
        }
    }
    func calculateWithGpu() {
        durationWithGpu = "Wait..."
        calculationDemo.calculateWithGpu() { duration in
            durationWithGpu = duration
        }
    }
    
    func compare() {
        compareResult = "Wait..."
        Task.detached {
            let diffs = calculationDemo.compare()
            await MainActor.run { compareResult = diffs == 0 ? "Equal" : "Diff: \(diffs)" }
        }
    }
}

#Preview {
    CalculationContentView()
}
