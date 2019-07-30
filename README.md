# JustPopup 🤩

JustPopup is a lightweight library used to display custom popups 

Show animated popups made up from any views (either UIKit and SwiftUI) or view controllers. 

## Usage 🌈

```swift
let popup = Popup(SwiftUIView())
    .withCornerRadius(20)
    .withPresentationStyle(.crossDisolve)

popup.show()
```

## Building 🗿

```swift

var popup: Popup

// from SwiftUI view 
popup = Popup(SwiftUIView()) 
            .withPresentationDuration(2)

// from UIView
popup = Popup(someUIView)

// from controller
popup = Popup(ExistingPopupController())
```

## Dismission 🖕

JustPopup currently provides four possibilities to hide a popup: 

1. To dismiss a popup you may simply call  `.hide()` :

```swift
popup.hide()
```

2.  Alternatively, you may subscribe to some publisher, so when it emits anything popup will close:

```swift
popup      
    .subscribeToClosingPublisher(somePublisher)
    .showPopup()
```

3. Or you can make it dismissed with just a tap on it:

```swift
popup      
    .subscribeToClosingPublisher(somePublisher)
    .showPopup()
```

4. Also it is possible to make it disappeared in concrete time after showing

```swift
let popup = Popup(SwiftUIView()) 
    .withPresentationDuration(2)

// four years later

popup.show()

// it'll be dismissed in 2 seconds after showing
```

Additionally, why not combining them?

```swift

let popup = Popup(SomeView())
    .dismissOnTap()
    .withPresentationDuration(2)

popup.show()

// it'll be dismissed in 2 seconds or sooner if user taps it 
```

## Customization 🎶

Popups are very easy to customize as you can use cool functional-style syntax:

```swift

popup
    .withAnimationDuration(2)
    .withPresentationStyle(.fromBottom)
    .withDismissionStyle(.fromUp)
    .withCornerRadius(5)
    .fadesBackground(false)
```

## Integration 🤝

### Supporting SwiftUI view's onAppear animation

As far as I know  `.onAppear`-based animations in SwiftUI views aren't working at all and here's a way to make everything work properly:

Conform your view to PopupSwiftUIAnimatedView protocol. This protocol hasn't any requirements. It's up to you what to use for tracking the state of the view 

```swift
struct CoolView: View, PopupSwiftUIAnimatedView {

    @State private var appeared = false
    
    var body: some View {
        // code
        .onReceive(swiftUIViewAppearPublisher()) { value in
            self.appeared = value
        }        
    }
}
```

JustPopup will fire a notification when all presentation animations are finished so animations of this view will work correctly.


### Windows and Scenes

Scenes are the new pattern introduced in iOS 13 and if you're using them you should tell about this JustPopup somewhere early:

```swift
JustPopupPreferences.shared.shouldFollowScenePattern = true
```

#### More on windows

JustPopup assumes that you're using top window so If you have complex windows scheme you may pass needed window in popup initializer:

```swift
let popup = Popup(someView, fromWindow: someWindow)
```

## Installation 🔧

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

To integrate Tactile into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
use_frameworks!

pod 'JustPopup'
```

You may also try this pod just printing in console:

```
pod try https://github.com/glassomoss/JustPopup.git
```

## Contribution 💅

I doubt someone is ever going to do it.. Surprise me!
