//
//  Extension.swift
//
//
//  Created by Lumisilk on 2023/11/14.
//

import UIKit

extension RandomAccessCollection {
    /// For array [1, 2, 3, 4], this method returns [(nil, 1), (1, 2), (2, 3), (3, 4)].
    func adjacentPairsFromNil() -> some Sequence<(previous: Element?, current: Element)> {
        sequence(state: (previous: nil as Element?, iterator: makeIterator())) { state in
            guard let next = state.iterator.next() else { return nil }
            defer { state.previous = next }
            return (state.previous, next)
        }
    }
}
