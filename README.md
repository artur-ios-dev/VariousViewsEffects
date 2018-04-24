# Various View's Effects

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](http://cocoapods.org/?q=VariousViewsEffects) [![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/artrmz/VariousViewsEffects/blob/master/LICENSE) [![Build Status](https://travis-ci.org/artrmz/VariousViewsEffects.svg?branch=master)](https://travis-ci.org/artrmz/VariousViewsEffects)

Various view's effects for iOS, written in Swift. Allows you to animate views nicely with easy to use extensions.
Currently supported animations:

- **Glass Break**

![Example](Resources/glass-break.gif?raw=true "glass-break")

- **Explode**

![Example](Resources/explode.gif?raw=true "explode")

- **Snowflakes**

![Example](Resources/snowflakes.gif?raw=true "snowflakes")

## Requirements
- iOS 9.0+
- Xcode 9.2+
- Swift 4.1+

## Installing with [CocoaPods](https://cocoapods.org)

```ruby
use_frameworks!

pod 'VariousViewsEffects'
```

## Usage

```swift
view.explode()

view.breakGlass()

view.addSnowflakes(amount: 10, speed: .slow)
```

You can also customize how many pieces views breaks on, if the `view` which you call it on should be removed once animation is finished and also you can define a completion block which will be called after animation finishes.

```swift
view.explode(size: GridSize(columns: 15, rows: 21), removeAfterCompletion: true, completion: {
    print("animation finished")
})
```

Have fun! :)

#### Let me know!

If you find any issue or would like me to add anything, just create an issue on GitHub.

## License

	The MIT License (MIT)

	Copyright © 2017 Yalantis

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
