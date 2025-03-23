//
//  ContentView.swift
//  WeSplit
//
//  Created by Brad Rice on 3/23/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        let peopleCount: Double = Double(numberOfPeople + 2)
        let tipSelection: Double = Double(tipPercentage)
        let tipValue: Double = checkAmount * (tipSelection / 100)
        let grandTotal: Double = checkAmount + tipValue
        return grandTotal / peopleCount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
