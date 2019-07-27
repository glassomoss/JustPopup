# JustPopup 🤩

JustPopup is a lightweight library used to display custom popups 

Show animated popups made up from any views (either UIKIt and SwiftUI) or view controllers. 

## Usage:

```swift

let popup = PopupHostingViewController(rootView: SwiftUIView(), fromWindow: currentWindow)
    .withCornerRadius(20)
    .withPresentationStyle(.crossDisolve)

popup.show()

```

Please, note that you must pass a window so popup can return back to it after dismission.

### Dismission

To dismiss a popup you simply call  `.hide()` :

```swift

popup.hide()

```

### Customization

Popups are very easy to customize as you can use cool functional-style syntax:

```swift



```

## Installation 

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

To integrate Tactile into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'JustPopup'

```

