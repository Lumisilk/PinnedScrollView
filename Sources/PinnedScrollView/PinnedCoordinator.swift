//
//  PinnedCoordinator.swift
//
//
//  Created by Lumisilk on 2023/11/14.
//

import Combine
import SwiftUI

final class PinnedCoordinator: ObservableObject {
    
    let scrollViewName = UUID()
    
    @CurrentValue var headerFrames: [Namespace.ID: CGRect] = [:]
    @CurrentValue var headerOffsets: [Namespace.ID: CGFloat] = [:]
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = $headerFrames
            .debounce(for: DispatchQueue.main.minimumTolerance, scheduler: DispatchQueue.main)
            .sink { [unowned self] newFrames in
                self.update(headerFrames: newFrames)
            }
    }
    
    private func update(headerFrames: [Namespace.ID: CGRect]) {
        var newHeaderOffsets: [Namespace.ID: CGFloat] = [:]
        defer { headerOffsets = newHeaderOffsets }

        let headerFramePairs = headerFrames
            .sorted { $0.value.minY < $1.value.minY }
            .adjacentPairsFromNil()

        for (previous, current) in headerFramePairs {
            if let previous,
               case let touchingDistance = current.value.minY - previous.value.height,
               touchingDistance < 0 {
                newHeaderOffsets[previous.key] = -previous.value.minY + touchingDistance
            }

            if current.value.minY < 0 {
                newHeaderOffsets[current.key] = -current.value.minY
            } else {
                break
            }
        }
    }
}

private struct PinnedCoordinatorKey: EnvironmentKey {
    static let defaultValue: PinnedCoordinator? = nil
}

extension EnvironmentValues {
    var pinnedCoordinator: PinnedCoordinator? {
        get { self[PinnedCoordinatorKey.self] }
        set { self[PinnedCoordinatorKey.self] = newValue }
    }
}
