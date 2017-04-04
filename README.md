# AMTooltip

[![CI Status](http://img.shields.io/travis/amirdew/AMTooltip.svg?style=flat)](https://travis-ci.org/amirdew/AMTooltip)
[![Version](https://img.shields.io/cocoapods/v/AMTooltip.svg?style=flat)](http://cocoapods.org/pods/AMTooltip)
[![License](https://img.shields.io/cocoapods/l/AMTooltip.svg?style=flat)](http://cocoapods.org/pods/AMTooltip)
[![Platform](https://img.shields.io/cocoapods/p/AMTooltip.svg?style=flat)](http://cocoapods.org/pods/AMTooltip)


## Installation

AMTooltip is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AMTooltip"
```


## Usage

With focus view and default options:

```swift
          AMTooltipView(message: "some text",
                        focusView: focusView, //pass view you want show tooltip over it
                        target: self)  //you can pass UIViewController or UIView as target
```

With focus frame and default options:

```swift
          AMTooltipView(message: "some text",
                        focusFrame: CGRect(x:100, y:150, width:40, height:25) //pass view you want show tooltip over it
                        target: self)  //you can pass UIViewController or UIView as target
```


With custom options:

```swift

          AMTooltipView(
            options:AMTooltipViewOptions(
                textColor: UIColor.white,
                textBoxBackgroundColor: UIColor.gray,
                addOverlayView: false,
                lineColor: UIColor.gray,
                dotColor: UIColor.lightGray,
                dotBorderColor: UIColor.gray
            ),
            message: "some customized text",
            focusView: focusView,
            target: self)

```



## License

AMTooltip is available under the MIT license. See the LICENSE file for more info.
