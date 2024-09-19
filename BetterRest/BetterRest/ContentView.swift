//
//  ContentView.swift
//  BetterRest
//
//  Created by David Farcas on 18.09.2024.
//

import CoreML
import SwiftUI

struct ContentView: View {

    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1

    @State private var alertTitle = "Your ideal bedtime is "
    @State private var alertMessage = ""
    @State private var showingAlert = false

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }

    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    Text("When do you want to wake up?")
                        .font(.headline)

                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .onChange(of: wakeUp) {
                            calculateBedTime()
                        }
                }
                Section() {
                    Text("Desired amount of sleep")
                        .font(.headline)

                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .onChange(of: sleepAmount) {
                            calculateBedTime()
                        }
                }
                Section() {
                    Text("Daily coffee intake")
                        .font(.headline)

                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
                        .onChange(of: coffeeAmount) {
                            calculateBedTime()
                        }
//                    Picker(selection: $coffeeAmount, label: Text("Coffee Amount")) {
//                        ForEach(1..<21) { number in
//                            Text("\(number) \(number == 1 ? "cup" : "cups")")
//                        }
//                    }
                }

            }
            .navigationTitle("BetterRest")
            .onAppear() {
                calculateBedTime()
            }
            Text(alertTitle + alertMessage)
                .font(.largeTitle)
                .padding()
                .multilineTextAlignment(.center)

        }
    }

    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep

            alertTitle = "Your ideal bedtime is "
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
        }

        showingAlert = true

    }
}

#Preview {
    ContentView()
}
