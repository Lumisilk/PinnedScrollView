//
//  PinnedScrollView.swift
//
//
//  Created by Lumisilk on 2023/11/14.
//

import SwiftUI

private struct PinnedScrollViewModifier: ViewModifier {
    @StateObject private var coordinator = PinnedCoordinator()
    
    func body(content: Content) -> some View {
        content
            .coordinateSpace(name: coordinator.scrollViewName)
            .environment(\.pinnedCoordinator, coordinator)
    }
}

public extension View {
    func pinnedScrollView() -> some View {
        modifier(PinnedScrollViewModifier())
    }
}

struct PinnedScrollViewModifier_Previews: PreviewProvider {
    struct Child: View {
        @Binding var isReached: Bool
        
        var body: some View {
            Text("Heading" + (isReached ? " Reached" : ""))
                .font(.title)
                .frame(maxWidth: .infinity)
                .backport.background {
                    isReached ? Color.green : .yellow
                }
                .pinned { isReachedTop in
                    isReached = isReachedTop
                }
            
            Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
            )
            .padding(8)
        }
    }
    
    
    struct Container: View {
        @State var isHeaderReachedTop: [Bool] = .init(repeating: false, count: 20)

        var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(0..<isHeaderReachedTop.count), id: \.self) { index in
                        Child(isReached: $isHeaderReachedTop[index])
                    }
                }
            }
            .pinnedScrollView()
        }
    }

    static var previews: some View {
        Container()
    }
}
