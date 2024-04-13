//
//  ContentView.swift
//  TimeConverter
//
//  Created by Valeriia Rohatynska on 01/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var from = "hours"
    @State private var to = "minutes"
    @State private var inputValue = 0.0
    @FocusState private var inputIsFocused: Bool
    
    let timeUnits = ["seconds", "minutes", "hours", "days"]
    
    var unitMultiplier: [String: Double] = [
        "seconds": 1,
        "minutes": 60,
        "hours": 3600,
        "days": 86400
    ]
    
    var result: Double {
        let convertedToSeconds = inputValue * (unitMultiplier[from] ?? 1)
        
        let convertedToDesiredUnit = convertedToSeconds / (unitMultiplier[to] ?? 1)
        
        return convertedToDesiredUnit
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("From", selection: $from) {
                        ForEach(timeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Picker("To", selection: $to) {
                        ForEach(timeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Value to convert") {
                    TextField("Value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                }
                
                Section("Result in \(to)") {
                    Text("\(result.formatted())")
                }
            }.navigationTitle("Time Converter")
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
