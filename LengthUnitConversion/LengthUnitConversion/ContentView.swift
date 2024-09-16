//
//  ContentView.swift
//  LengthUnitConversion
//
//  Created by David Farcas on 16.09.2024.
//

import SwiftUI

struct ContentView: View {

    @State private var inputValue = 0.0
    @State private var inputUnit = "meters"
    @State private var outputUnit = "meters"
    @FocusState private var inputIsFocused: Bool
    let units = ["meters", "km", "feet", "yards", "miles"]
    var outputValue: Double {
        switch inputUnit {
        case "meters":
            switch outputUnit {
            case "meters":
                return inputValue
            case "km":
                return inputValue / 1000
            case "feet":
                return inputValue * 3.28084
            case "yards":
                return inputValue * 1.09361
            case "miles":
                return inputValue / 1609.34
            default:
                return 0
            }
        case "km":
            switch outputUnit {
            case "meters":
                return inputValue * 1000
            case "km":
                return inputValue
            case "feet":
                return inputValue * 3280.84
            case "yards":
                return inputValue * 1093.61
            case "miles":
                return inputValue / 1.60934
            default:
                return 0
            }
        case "feet":
            switch outputUnit {
            case "meters":
                return inputValue / 3.28084
            case "km":
                return inputValue / 3280.84
            case "feet":
                return inputValue
            case "yards":
                return inputValue / 3
            case "miles":
                return inputValue / 5280
            default:
                return 0
            }
        case "yards":
            switch outputUnit {
            case "meters":
                return inputValue / 1.09361
            case "km":
                return inputValue / 1093.61
            case "feet":
                return inputValue * 3
            case "yards":
                return inputValue
            case "miles":
                return inputValue / 1760
            default:
                return 0
            }
        case "miles":
            switch outputUnit {
            case "meters":
                return inputValue * 1609.34
            case "km":
                return inputValue * 1.60934
            case "feet":
                return inputValue * 5280
            case "yards":
                return inputValue * 1760
            case "miles":
                return inputValue
            default:
                return 0
            }
        default:
            return 0
        }
    }
    var body: some View {
        NavigationStack {
            Form {
                Section("Input value") {
                    TextField("Enter a value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)

                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Output value") {
                    Text(outputValue, format: .number)

                    Picker("Input unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Length units convertor")
            .toolbar {
                if inputIsFocused {
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
