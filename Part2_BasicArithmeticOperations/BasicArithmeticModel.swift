//
//  BasicArithmeticModel.swift
//  Part2_BasicArithmeticOperations
//
//  Created by hiraoka on 2021/03/23.
//

import Foundation

class BasicArithmeticModel: ObservableObject {
    
    enum Operation:  String, CaseIterable {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "×"
        case divide = "÷"
    }

    enum BasicArithmeticError: Error {
        case divideByZero
        
        var message: String {
            switch self {
            case .divideByZero:
                return "割る数には0以外を入力して下さい"
            }
        }
    }
    
    enum ResultState {
        case success(Double)
        case failure(BasicArithmeticError)
    }

    let operations = Operation.allCases
    @Published var values: [String] = ["", ""]
    @Published var selectedOperation: Operation = .addition
    @Published var resultState: ResultState?
    
    func calculate() {
        
        let castedValues = values.compactMap { Double($0) }
        
        guard let firstValue = castedValues.first else {
            resultState = .none
            return
        }
        
        let secondToLastValues = castedValues.dropFirst()
        
        if selectedOperation == .divide,
           secondToLastValues.contains(where: { $0 == .zero }) {
            resultState = .failure(.divideByZero)
            return
        }
        
        let result = secondToLastValues.reduce(firstValue) { (result, value) in
            switch selectedOperation {
            case .addition:
                return result + value
            case .subtraction:
                return result - value
            case .multiplication:
                return result * value
            case .divide:
                return result / value
            }
        }
        
        resultState = .success(result)
    }
}
