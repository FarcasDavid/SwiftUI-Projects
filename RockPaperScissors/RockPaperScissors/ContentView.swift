//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by David Farcas on 18.09.2024.
//

import SwiftUI

struct moveAppearance: View {
    var moveTitle: String

    var body: some View {
        Text(moveTitle)
            .font(.system(size: 60))
            .padding(15)
            .background(Color.white.opacity(0.5))
            .clipShape(.capsule)

    }
}
struct ContentView: View {
    let moves = ["✊", "✋", "✌️"]
    let winningMoves =  ["✋", "✌️", "✊"]
    @State private var currentMove = Int.random(in: 0...2)
    @State private var shouldWin: Bool = Bool.random()
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var numberOfRounds = 0
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .indigo, location: 0.4),
                .init(color: .orange, location: 0.6)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Rock Paper Scissors")
                    .font(.largeTitle).bold()
                    .foregroundStyle(.white)
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("App choses")
                            .font(.subheadline).bold()
                            .foregroundStyle(.secondary)
                        Text(moves[currentMove])
                            .font(.largeTitle).bold()
                            .foregroundStyle(.black)
                        Text("Choose a move in order to")
                            .font(.title3).bold()
                            .foregroundStyle(.secondary)
                        Text("\(shouldWin ? " Win" : " Lose")")
                            .font(.title3).bold()
                            .foregroundStyle(shouldWin ? .green : .red)
                    }
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                moveTapped(number)
                            } label: {
                                moveAppearance(moveTitle: moves[number])
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score \(score) / 10")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Final Score", isPresented: $showingFinalScore) {
            Button("Restart Game", action: restartGame)
        } message: {
            Text("Your Final Score is \(score) / 10")
        }
    }
    func moveTapped(_ number: Int) {
        if (shouldWin && moves[number] == winningMoves[currentMove]) || (!shouldWin && moves[number] != winningMoves[currentMove]) {
            scoreTitle = "Correct!"
            score += 1
        } else if shouldWin {
            scoreTitle = "Wrong. The correct choice was \(winningMoves[currentMove])"
        } else {
            scoreTitle = "Wrong."
        }
        numberOfRounds += 1

        if numberOfRounds == 10 {
            showingFinalScore = true
        } else {
            showingScore = true
        }
    }

    func askQuestion() {
        currentMove = Int.random(in: 0...2)
        shouldWin.toggle()
    }

    func restartGame() {
        score = 0
        numberOfRounds = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
