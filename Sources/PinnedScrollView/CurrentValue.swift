//
//  CurrentValue.swift
//
//
//  Created by Lumisilk on 2023/11/08.
//

import Combine

@propertyWrapper
struct CurrentValue<Value> {
    
    let subject: CurrentValueSubject<Value, Never>
    
    init(wrappedValue initialValue: Value) {
        subject = .init(initialValue)
    }
    
    var wrappedValue: Value {
        get { subject.value }
        set { subject.send(newValue) }
    }
    
    var projectedValue: some Publisher<Value, Never> {
        subject
    }
}
