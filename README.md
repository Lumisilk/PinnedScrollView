## PinnedScrollView

PinnedScrollView is a tiny SwiftUI library that helps you pin any view in a scrollview like a header, without using  `LazyVStack` and `Section`.

## Usage

```swift
var body: some View {
    ScrollView {
        VStack(spacing: 0) {
            ForEach(0..<20) { _ in
                Text("Header")
                    .pinned() // 1
                
                Text("Some content text")
            }
        }
    }
    .pinnedScrollView() // 2
```

1. Add `.pinned()` modifier to the view you want to pin within the scrollview
2. Add `.pinnedScrollView()` modifier to the corresponding scrollview

That's it!



You can also provide a optional closure `onReachedTop: (Bool) -> ()` to the `pinned` modifier if you want to get a notification when the pinned state changed.

```swift
@State private var isHeaderReachedTop = false
// ...
Text("Header" + (isHeaderReachedTop ? " Reached" : ""))
    .pinned { isReachedTop in
        isHeaderReachedTop = isReachedTop
    }
```

## Limitation

PinnedScrollView needs iOS/iPadOS 14.0.

PinnedScrollView only supports vertical `ScrollView` and doesn't support horizontal `ScrollView` or the `List` view.

## Installation

Use [Swift Package Manager](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app) to add PinnedScrollView to your project.

`https://github.com/Lumisilk/PinnedScrollView.git`

### License

This package is licensed under the MIT open-source license.