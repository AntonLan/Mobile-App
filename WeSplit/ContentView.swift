//
//  ContentView.swift
//  WeSplit
//
//  Created by Anton Gerasimov on 22.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmout = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var totalAmount: Double {
        return (checkAmout / 100 * Double(tipPercentage)) + checkAmout
    }
    
    var currencyIdentifier: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    var totalPerPerson: Double {
        let countPeople = Double(numberOfPeople + 2)
        return totalAmount/countPeople
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmout, format: currencyIdentifier)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Percent", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyIdentifier)
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    Text(totalAmount, format:currencyIdentifier)
                } header: {
                    Text("Total amount")
                }
            }
            .navigationTitle("Bill")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
