//
//  ContentView.swift
//  HeavyMetal
//
//  Created by Dimitri Brukakis on 28.08.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {

            Text("🤘😎 Heavy Metal")
                .font(.title)

            List {

                NavigationLink(destination: CalculationContentView()) {
                    label(title: "Calculation")
                }
                NavigationLink(destination: EasyShaderContentView()) {
                    label(title: "Easy shader")
                }
                NavigationLink(destination: AnimatedShaderContentView()) {
                    label(title: "Animated shader")
                }
                NavigationLink(destination: PiratesShaderContentView()) {
                    label(title: "Arrrr 🏴‍☠️")
                }
                NavigationLink(destination: HardRockDemoContentView()) {
                    label(title: "Hard Rock 🤘")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
    
    func label(title: String) -> Label<Text, some View> {
        Label(
            title: { 
                Text(title)
                    .font(.body)
                    .foregroundStyle(Color.black) },
            icon: {
                Image(systemName: "menucard")
                    .foregroundColor(.black)
                    .font(.body)
            }
        )
    }
}

#Preview {
    ContentView()
}
