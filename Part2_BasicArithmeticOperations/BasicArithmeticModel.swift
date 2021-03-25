//
//  BasicArithmeticModel.swift
//  Part2_BasicArithmeticOperations
//
//  Created by hiraoka on 2021/03/23.
//

import Foundation

enum Operation:  String, CaseIterable {
    case addition = "+"
    case subtraction = "-"
    case multiplication = "×"
    case divide = "÷"

    var f: (Double, Double) -> Double {
        switch self {
        case .addition:
            return (+)
        case .subtraction:
            return (+)
        case .multiplication:
            return (+)
        case .divide:
            return (+)
        }
    }
}

final class BasicArithmeticModel: ObservableObject {
    
    enum State {
        case initial
        case success(Double)
        case failure(String)
    }

    let operations = Operation.allCases
    @Published var values: [String] = ["", ""]
    @Published var selectedOperation: Operation = .addition
    @Published var resultState: State = .initial
    
    func calculate() {
        let castedValues = values.compactMap { Double($0) }

        switch Calculator().calculate(values: castedValues, ope: selectedOperation) {
        case let .success(value):
            resultState = .success(value)
        case let .failure(error):
            switch error {
            case .divideByZero:
                resultState = .failure("割る数には0以外を入力して下さい")
            case .valuesIsEmpty:
                resultState = .initial
            }
        }
    }
}

struct Calculator {
    enum BasicArithmeticError: Error {
        case divideByZero
        case valuesIsEmpty
    }

    enum CalculationResult {
        case success(Double)
        case failure(BasicArithmeticError)
    }

    func calculate(values: [Double], ope: Operation) -> CalculationResult {
        guard let firstValue = values.first else {
            return .failure(.valuesIsEmpty)
        }

        let secondToLastValues = values.dropFirst()

        if ope == .divide,
           secondToLastValues.contains(where: { $0 == .zero }) {
            return .failure(.divideByZero)
        }

        return .success(
            secondToLastValues.reduce(firstValue, ope.f)
        )
    }
}
