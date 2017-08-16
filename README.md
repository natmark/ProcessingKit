![Header](https://github.com/natmark/ProcessingKit/blob/master/Resources/ProcessingKit-Header.png?raw=true)

<p align="center">
    <a href="https://travis-ci.com/natmark/ProcessingKit">
        <img src="https://travis-ci.com/natmark/ProcessingKit.svg?token=nzmukddH8XeX8xpNA4qP&branch=master"
             alt="Build Status">
    </a>
    <a href="https://cocoapods.org/pods/ProcessingKit">
        <img src="https://img.shields.io/cocoapods/v/ProcessingKit.svg?style=flat"
             alt="Pods Version">
    </a>
    <a href="https://github.com/ProcessingKit/">
        <img src="https://img.shields.io/cocoapods/p/ProcessingKit.svg?style=flat"
             alt="Platforms">
    </a>
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat"
             alt="Carthage Compatible">
    </a>
</p>

----------------

# ProcessingKit
ProcessingKit is a Visual Programming library for iOS.  
ProcessingKit written in Swift🐧 and you can write like [processing](https://github.com/processing/processing).

## Demo
![Demo](https://github.com/natmark/ProcessingKit/blob/master/Resources/demo.gif?raw=true)

## Usage
1. Create a class that inherits ProcessingView & conform to ProcessingViewDelegate

```Swift
import ProcessingKit

class SampleView: ProcessingView, ProcessingViewDelegate {
    func setup() {
    }
    func draw() {
    }
}
```

2. Create a SampleView instance
### Create programmatically
```Swift
    lazy var sampleView:SampleView = {
        let sampleView = SampleView(frame: frame)
        sampleView.delegate = sampleView
        sampleView.isUserInteractionEnabled = true // If you want to use touch events
        return sampleView
    }()
```

### Use StoryBoard

Connect the UIImageView to SampleView Class 

![ScreenShot](https://github.com/natmark/ProcessingKit/blob/master/Resources/Storyboard-Usage.png?raw=true)

```Swift
 @IBOutlet weak var sampleView: SampleView!
 
 override func viewDidLoad() {
     super.viewDidLoad()
     
     sampleView.delegate = sampleView
     sampleView.isUserInteractionEnabled = true // If you want to use touch events
 }
```

## Instration
### [Carthage](https://github.com/Carthage/Carthage)
Add this to `Cartfile`
```
  github "natmark/ProcessingKit"
```

## License
ProcessingKit is available under the MIT license. See the LICENSE file for more info.
