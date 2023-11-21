## PinnedScrollView

PinnedScrollView is a tiny SwiftUI library that helps you pin any view in a scrollview like a header, without using  `LazyVStack` and `Section`.

<img src="https://github.com/Lumisilk/PinnedScrollView/assets/11924267/d18bed21-db75-4942-a85a-93eac4771894" width="300"/>

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
}
```

1. Add `.pinned()` modifier to the view you want to pin within the scrollview
2. Add `.pinnedScrollView()` modifier to the corresponding scrollview

That's it!

#### Optional observation

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

PinnedScrollView requires iOS/iPadOS 14.0.

PinnedScrollView only supports vertical `ScrollView` and doesn't support horizontal `ScrollView` or the `List` view.

## Installation

Use [Swift Package Manager](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app) to add PinnedScrollView to your project.

`https://github.com/Lumisilk/PinnedScrollView.git`

## License

This package is licensed under the MIT open-source license.

## Inspiration

The implementation of PinnedScrollView was inspired by objc.io's course on [Sticky Headers for Scroll Views](https://talk.objc.io/episodes/S01E333-sticky-headers-for-scroll-views).
Unlike the original implementation from objc.io, which uses `PreferenceKey` to coordinate the frames of headers and can lead to performance bottlenecks, PinnedScrollView use `onChange` to efficiently record the frames of headers.

Additionally, PinnedScrollView use Combine's `debounce` and publisher to minimize the re-evaluation count of the headers' body, aiming to optimize performance.

Special thanks to [@auramagi](https://github.com/auramagi) for the algorithm suggestions.

