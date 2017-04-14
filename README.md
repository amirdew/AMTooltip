# AMTooltip

[![CI Status](http://img.shields.io/travis/amirdew/AMTooltip.svg?style=flat)](https://travis-ci.org/amirdew/AMTooltip)
[![Version](https://img.shields.io/cocoapods/v/AMTooltip.svg?style=flat)](http://cocoapods.org/pods/AMTooltip)
[![License](https://img.shields.io/cocoapods/l/AMTooltip.svg?style=flat)](http://cocoapods.org/pods/AMTooltip)
[![Platform](https://img.shields.io/cocoapods/p/AMTooltip.svg?style=flat)](http://cocoapods.org/pods/AMTooltip)

## Screenshots

<img width="375" src="https://raw.githubusercontent.com/amirdew/AMTooltip/master/Example/screenshots_1.png"><img width="375" src="https://raw.githubusercontent.com/amirdew/AMTooltip/master/Example/screenshots_2.png">


## Requirements

iOS 8+

Expample write in Xcode 8.3 - Swift 3.1


## Installation

AMTooltip is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AMTooltip"
```


## Usage (swift 3)

```swift
import AMTooltip
```



With focus view and default options:

```swift
          AMTooltipView(message: "some text",
                        focusView: focusView, //pass view you want show tooltip over it
                        target: self)  //you can pass UIViewController or UIView as target
```

With focus frame and default options:

```swift
          AMTooltipView(message: "some text",
                        focusFrame: CGRect(x:100, y:150, width:40, height:25)
                        target: self) 
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

With dismiss closure:

```swift

        AMTooltipView(message: "some text",
                      focusView: focusView,
                      target: self) {
                      
                        print("tooltip dismissed") 
        }
```

## Options

| Name | Type | Default | Description |
|:----:|:----:|:---:|:-------:|
|side|AMTooltipViewSide|```.auto```|Side of show tooltip ```(.auto/.top/.bottom)```
|textColor|UIColor|```UIColor.black```|Color of message text
|textWidth|CGFloat|```270```|Width of message
|font|UIFont|```UIFont.systemFont(ofSize: 14)```|Font of message text
|textAlignment|NSTextAlignment|```.natural```|Alignment of message text
|textBoxBackgroundColor|UIColor|```UIColor.white```|Color of message box
|textBoxCornerRadius|CGFloat|```6```|Radius for corners of message box
|textBoxBorderColor|UIColor|```UIColor.clear```|Color for border of message box
|textBoxBorderWidth|CGFloat|```0```|Width for border of message box
|addOverlayView|Bool|```true```|if false dark overlay view hide
|overlayBackgroundColor|UIColor|```UIColor.black.withAlphaComponent(0.4)```|Color of overlay view
|lineColor|UIColor|```UIColor.white```|Color of pin line view
|lineWidth|CGFloat|```2```|Width of pin line view
|lineHeight|CGFloat|```30```|Height of pin line view
|dotColor|UIColor|```UIColor.lightGray```|Color of pin dot
|dotSize|CGFloat|```13```|Size of pin dot
|dotBorderWidth|CGFloat|```2```|Size for border of pin dot 
|dotBorderColor|UIColor|```UIColor.white```|Color for border of pin dot
|focusViewRadius|CGFloat|```6```|Radius for corners of focused view
|focustViewVerticalPadding|CGFloat|```5```|Vertical padding for focused view
|focustViewHorizontalPadding|CGFloat|```15```|Horizontal padding for focused view

## Todo
 * ~~Add support for screen rotate~~
 * ~~Adjust messageBox with target view frame~~
 * Support left and right side
 * Custom animations
 * Custom pointers (arrow, images, ...)
 * Custom view instead tooltip box


## License

AMTooltip is available under the MIT license. See the LICENSE file for more info.
