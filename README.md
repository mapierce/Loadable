![logo](https://i.imgur.com/TFLnbfK.png)

[![Build Status](https://app.bitrise.io/app/e89c0d6172145d37/status.svg?token=hwyljiO1CFXgPTTp5f-y7A&branch=master)](https://app.bitrise.io/app/e89c0d6172145d37)
[![Version](https://img.shields.io/cocoapods/v/Loadable.svg?style=flat)](https://cocoapods.org/pods/Loadable)
[![License](https://img.shields.io/cocoapods/l/Loadable.svg?style=flat)](https://cocoapods.org/pods/Loadable)
[![Platform](https://img.shields.io/cocoapods/p/Loadable.svg?style=flat)](https://cocoapods.org/pods/Loadable)

## 🤔 About 

Loadable allows you to attach `Progress` to any `UIView` or subclass and then use the `UIView` to display progress. You can animate the progress, set the progress colour and show or hide the percentage progress in the bottom corner of your view. Please see below for demos of Loadable working on a `UIView` and a `UISegmentControl`.

<p align="center">
  <img src="https://i.imgur.com/g73LOXs.gif">  
  <img src="https://i.imgur.com/g2nBipd.gif">  
</p>

## 🔛 Demo 

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 📲 Installation 

Loadable is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Loadable'
```

and run `pod install`

## ✅ Requirements 
- Swift 5.0
- iOS 11.0

## 👩‍💻 How to use

Loadable can be used on any `UIView` or subclass. As it is built as an extension of `UIView`, the only thing you need to do to use it is import it at the top of your file. After that you can configure the view you want to use as a loading view with a few different options as follows:

```swift
let viewToShowLoading: UIView = UIView()
let progress = Progress(totalUnitCount: 100)

viewToShowLoading.monitoredProgress = progress 

// everything from here on is optional configuration. The lines above will setup everything

viewToShowLoading.animateProgrss = true
viewToShowLoading.progressColor = .blue
viewToShowLoading.showPercentage = true
viewToShowLoading.progressPercentageFontSize = 12.0
viewToShowLoading.progressPercentageFontColor = .red
viewToShowLoading.clearOnComplete = false
```

As you can see from the comment in the above snippet, all that is necessary to make the `UIView` become a Loadable one is attaching some `Progress` to the new `monitoredProgress` property. After that you can configure the Loadable view any way you like.

## 👨‍👩‍👧‍👦 Contributing

If you run into any problems, please submit an issue. Pull requests are also welcome! By contributing to Loadable you agree that your contributions will be licensed under its MIT license.

If you use Loadable in your app I'd love to hear from you on [Twitter](https://twitter.com/PierceMatthew)!

## 🙋‍♂️ Author

WaveTab was created by Matthew Pierce ([@PierceMatthew](https://twitter.com/PierceMatthew))

## 🔖 License

Loadable is available under the MIT license. See the LICENSE file for more info.
