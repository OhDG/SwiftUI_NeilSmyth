//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by 오동규 on 7/12/24.
//

import SwiftUI

struct ContentView: View {

    var colors: [Color] = [.black, .red, .green, .blue]
    var colornames =  ["Black", "Red", "Green", "Blue"]

    @State private var colorIndex = 0
    @State private var rotation: Double = 0
    @State private var text: String = "Welcome to SwiftUI"

    var body: some View {
        VStack {
            VStack {
                Spacer()
                Text(text)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .rotationEffect(.degrees(rotation))
                    .animation(.easeInOut(duration: 5), value: rotation)
                    .foregroundColor(colors[colorIndex])
                Spacer()
                Divider()

                Slider(value: $rotation, in: 0 ... 360, step: 0.1)
                    .padding()

                TextField("Enter text here", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Picker(selection: $colorIndex, label: Text("Color")) {
                    ForEach (0 ..< colornames.count, id:\.self) { color in
                        Text(colornames[color])
                            .foregroundColor(colors[color])
                    }
                }
                .pickerStyle(.wheel)
                .padding()
            }
        }
    }
}


#Preview {
    ContentView()
}
