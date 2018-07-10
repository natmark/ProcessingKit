![Header](https://github.com/natmark/ProcessingKit/blob/master/Resources/ProcessingKit-Header.png?raw=true)

<p align="center">
    <a href="https://travis-ci.org/natmark/ProcessingKit">
        <img src="https://travis-ci.org/natmark/ProcessingKit.svg?branch=master"
             alt="Build Status">
    </a>
    <a href="https://cocoapods.org/pods/ProcessingKit">
        <img src="https://img.shields.io/cocoapods/v/ProcessingKit.svg?style=flat"
             alt="Pods Version">
    </a>
    <a href="https://github.com/natmark/ProcessingKit/">
        <img src="https://img.shields.io/cocoapods/p/ProcessingKit.svg?style=flat"
             alt="Platforms">
    </a>
    <a href="https://github.com/apple/swift">
        <img alt="Swift" src="https://img.shields.io/badge/swift-4.0-orange.svg">
    </a>
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat"
             alt="Carthage Compatible">
    </a>
    <a href="https://codecov.io/gh/natmark/ProcessingKit">
        <img alt="codecov" src="https://codecov.io/gh/natmark/ProcessingKit/branch/master/graph/badge.svg">
    </a>
</p>

----------------

# ProcessingKit
ProcessingKit is a Visual designing library for iOS & OSX.
ProcessingKit written in Swift🐧 and you can write like [processing](https://github.com/processing/processing).

## Demo
![Demo](https://github.com/natmark/ProcessingKit/blob/master/Resources/demo.gif?raw=true)

### Demo Apps
- [iOS Official Demo](https://github.com/natmark/ProcessingKit/tree/master/ProcessingKitExample)
- [OSX Official Demo](https://github.com/natmark/ProcessingKit/tree/master/ProcessingKitOSXExample)
- [iPad Demo App (Developed for Open Source Conference)](https://github.com/natmark/OSCProcessingKitDemo)

## Example
|OS|gif|code| 
|:---:|:------:|:------:|
|iOS| <img src="https://raw.githubusercontent.com/natmark/ProcessingKit/master/Resources/iOS_Example.gif" alt="gif"  height="50%"> | ![code](https://raw.githubusercontent.com/natmark/ProcessingKit/master/Resources/iOS_ExampleCode.png)|
|OSX| ![gif](https://raw.githubusercontent.com/natmark/ProcessingKit/master/Resources/OSX_Example.gif) | ![code](https://raw.githubusercontent.com/natmark/ProcessingKit/master/Resources/OSX_ExampleCode.png)|

## Requirements
- Swift 3.0 or later
- iOS 10.0 or later
- OSX 10.11 or later

If you use Swift 3.x, try [ProcessingKit 0.6.0](https://github.com/natmark/ProcessingKit/releases/tag/0.6.0).

## Usage
1. Create custom class that inherits from ProcessingView

```Swift
import ProcessingKit

class SampleView: ProcessingView {
    func setup() {
        // The setup() function is run once, when the program starts.
    }
    func draw() {
        // Called directly after setup(), the draw() function continuously executes the lines of code contained inside its block until the program is stopped or noLoop() is called.
    }
}
```

2. Create a SampleView instance
### Create programmatically
```Swift
    lazy var sampleView: SampleView = {
        let sampleView = SampleView(frame: frame)
        sampleView.isUserInteractionEnabled = true // If you want to use touch events (default true)
        return sampleView
    }()
```

### Use StoryBoard

Connect the (UIImageView / NSImageView) to SampleView Class

```Swift
 @IBOutlet weak var sampleView: SampleView!

 override func viewDidLoad() {
     super.viewDidLoad()
     sampleView.isUserInteractionEnabled = true // If you want to use touch events (default true)
 }
```

## Installation

### [CocoaPods](http://cocoadocs.org/docsets/ProcessingKit/)
Add the following to your `Podfile`:
```
  pod "ProcessingKit"
  pod "ProcessingKit", "~> 0.6.0" # If you use Swift 3.x
```

- (Example project here: [PKPodsExample](https://github.com/natmark/PKPodsExample))

### [Carthage](https://github.com/Carthage/Carthage)
Add the following to your `Cartfile`:
```
  github "natmark/ProcessingKit"
  github "natmark/ProcessingKit" ~> 0.6.0 # If you use Swift 3.x
```

- (Example project here: [PKExample](https://github.com/natmark/PKExample))

## Xcode File Template
- `ProcessingKit.xctemplate` is available.
- Use [Donut](https://github.com/natmark/Donut)(Xcode file template manager) to install.

`$ donut install https://github.com/natmark/ProcessingKit`

## License
ProcessingKit is available under the MIT license. See the LICENSE file for more info.
