AccessibilityExamples
=====================

![Swift 5](https://img.shields.io/badge/Swift-5-orange.svg) ![platforms](https://img.shields.io/badge/platforms-iOS-lightgrey.svg) [![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/nua-schroers/AccessibilityExamples/master/LICENSE) ![Travis build](https://travis-ci.org/nua-schroers/AccessibilityExamples.svg?=master)

Executive Summary
-----------------

This is a collection of common use cases for VoiceOver on iOS. Open `AccessibilityExamples.xcodeproj` using Xcode 10.2 (the current version requires Swift 5 and is not source code-compatible with earlier versions). I strongly recommend that you use a real iPhone.

The license is MIT (cf. the included file [LICENSE](https://raw.githubusercontent.com/nua-schroers/AccessibilityExamples/master/LICENSE)).

Features
--------

The project contains four views that demonstrate different ways
VoiceOver can be used within your app:
* A view with a label and a switch. With VoiceOver it behaves like a switch.
* A view with a label and a slider. With VoiceOver it behaves like a slider.
* A view with several custom-drawn elements. These are not accessible by default so several non-trivial steps must be taken to make them usable with VoiceOver.
* A view with a button and a label that can be shown and hidden using the button. With VoiceOver these two elements are separately accessible.
* A view with a button and a time progress. Without VoiceOver the progress bar grows from 0 to 1 within 20 seconds. With VoiceOver the progress is reported every five seconds.
