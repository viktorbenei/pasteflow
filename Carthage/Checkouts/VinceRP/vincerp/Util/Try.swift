//
// Created by Viktor Belenyesi on 20/04/15.
// Copyright (c) 2015 Viktor Belenyesi. All rights reserved.
//
// https://github.com/scala/scala/blob/2.11.x/src/library/scala/util/Try.scala

public enum Try<T:Equatable>: CustomStringConvertible, Equatable {

    case Success(Box<T>)
    case Failure(NSError)

    public init(_ error: NSError) {
        self = .Failure(error)
    }

    public init(_ value: T) {
        self = .Success(Box(value))
    }

    public init(_ value: Box<T>) {
        self = .Success(value)
    }

    public func isSuccess() -> Bool {
        switch self {
        case .Success:
            return true
        case .Failure:
            return false
        }
    }

    public func isFailure() -> Bool {
        switch self {
        case .Success:
            return false
        case .Failure:
            return true
        }
    }

    public func map<U>(transformFunc: T -> U) -> Try<U> {
        switch self {
        case .Success(let box):
            return .Success(Box(transformFunc(box.value)))
        case .Failure(let error):
            return .Failure(error)
        }
    }

    public var description : String {
        switch self {
        case .Success(let box):
            return "Success: \(box.value)"
        case .Failure(let error):
            return "Failure: \(error)"
        }
    }

}

public func ==<T>(lhs: Try<T>, rhs: Try<T>) -> Bool {
    switch (lhs, rhs) {
        case (.Success(let l), .Success(let r)): return l.value == r.value
        case (.Failure(let l), .Failure(let r)): return l == r
        default: return false
    }
}

