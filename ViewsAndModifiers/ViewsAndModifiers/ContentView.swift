//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by David Farcas on 17.09.2024.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle).bold()
            .foregroundStyle(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(TitleModifier())
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {

    var body: some View {
        Text("A 4 x 4 Grid")
            .titleStyle()
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
    }
}

#Preview {
    ContentView()
}
