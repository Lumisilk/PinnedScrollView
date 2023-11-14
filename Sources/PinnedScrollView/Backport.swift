//
//  Backport.swift
//
//
//  Created by Lumisilk on 2023/11/14.
//

import SwiftUI

struct Backport<Content: View> {
    let selfContent: Content
    
    @ViewBuilder
    func background(alignment: Alignment = .center, @ViewBuilder content: () -> some View) -> some View {
        if #available(iOS 15, *) {
            selfContent.background(alignment: alignment, content: content)
        } else {
            selfContent.background(content(), alignment: alignment)
        }
    }
    
    @ViewBuilder
    func overlay(alignment: Alignment = .center, @ViewBuilder content: () -> some View) -> some View {
        if #available(iOS 15, *) {
            selfContent.overlay(alignment: alignment, content: content)
        } else {
            selfContent.overlay(content(), alignment: alignment)
        }
    }
}

extension View {
    var backport: Backport<Self> {
        Backport(selfContent: self)
    }
}
