//
//  PinnedModifier.swift
//  
//
//  Created by Lumisilk on 2023/11/14.
//

import Combine
import SwiftUI

private struct PinnedModifier: ViewModifier {
    @Environment(\.pinnedCoordinator) private var coordinator
    
    @Namespace private var id
    @State private var offset: CGFloat = 0
    
    var onReachedTop: ((Bool) -> ())?

    func body(content: Content) -> some View {
        content
            .offset(y: offset)
            .onReceive(offsetPublisher) { offset = $0 }
            .backport.overlay {
                if let coordinator {
                    GeometryReader { proxy in
                        let frame = proxy.frame(in: .named(coordinator.scrollViewName))
                        Color.clear
                            .onChange(of: frame) { frame in
                                coordinator.headerFrames[id] = frame
                                onReachedTop?(frame.minY <= 0)
                            }
                    }
                    .hidden()
                }
            }
            .zIndex(1)
    }

    var offsetPublisher: some Publisher<CGFloat, Never> {
        if let coordinator {
            return coordinator
                .$headerOffsets
                .map { $0[id] ?? 0 }
                .removeDuplicates()
                .eraseToAnyPublisher()
        } else {
            return Empty().eraseToAnyPublisher()
        }
    }
}

public extension View {
    func pinned(onReachedTop: ((Bool) -> ())? = nil) -> some View {
        modifier(PinnedModifier(onReachedTop: onReachedTop))
    }
}
