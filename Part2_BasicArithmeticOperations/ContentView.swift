//
//  ContentView.swift
//  Part2_BasicArithmeticOperations
//
//  Created by hiraoka on 2021/03/20.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model: BasicArithmeticModel = .init()
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(spacing: 16) {
                
                VStack(spacing: 20) {
                    
                    ForEach(0 ..< model.values.count, id: \.self) { index in
                        TextField("", text: $model.values[index])
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    
                    Picker(selection: $model.selectedOperation, label: EmptyView()) {
                        ForEach(model.operations, id: \.self) { operation in
                            Text(operation.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button("Button", action: model.calculate)
                }
                .padding(.horizontal, 80)
                
                Group {
                    switch model.resultState {
                    case .success(let result):
                        Text(String(result))
                    case .failure(let error):
                        Text(error.message)
                    default:
                        EmptyView()
                    }
                }
                .frame(width: geometry.frame(in: .global).width - 32, alignment: .leading)
                
            }
            .frame(width: geometry.frame(in: .global).width,
                   alignment: .topLeading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
