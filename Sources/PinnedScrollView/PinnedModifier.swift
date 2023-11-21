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
                        let isReachedTop = frame.minY <= 0
                        Color.clear
                            .onAppear {
                                coordinator.headerFrames[id] = frame
                            }
                            .onChange(of: frame) { frame in
                                coordinator.headerFrames[id] = frame
                            }
                            .onAppear {
                                onReachedTop?(isReachedTop)
                            }
                            .onChange(of: isReachedTop) { isReachedTop in
                                onReachedTop?(isReachedTop)
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
    /// The .pinned() modifier is used to pin a view within a ScrollView. 
    ///
    /// When applied, it keeps the view fixed at the top of the ScrollView while the rest of the content scrolls.
    /// Note: You must also apply the `.pinnedScrollView()` modifier to the corresponding ScrollView for this modifier to have any effect.
    ///
    /// - Parameter onReachedTop: An optional closure that is executed when the pinned view reaches or leaves the top of the ScrollView. Note that this value remains `true` if the pinned view scrolls upwards out of the visible range.
    func pinned(onReachedTop: ((Bool) -> ())? = nil) -> some View {
        modifier(PinnedModifier(onReachedTop: onReachedTop))
    }
}
