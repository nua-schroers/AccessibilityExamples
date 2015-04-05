AccessibilityExamples
=====================

Executive Summary
-----------------

This is a collection of common use cases for VoiceOver on iOS. Open `AccessibilityExamples.xcodeproj` using Xcode 6.2 or higher. I strongly recommend that you use an actual iPhone.

The license is MIT (cf. the included file `LICENSE`).

Features
--------

The project contains four views that demonstrate different ways
VoiceOver can be used within your app:
* A view with a label and a switch. With VoiceOver it behaves like a switch.
* A view with a label and a slider. With VoiceOver it behaves like a slider.
* A view with several custom-drawn elements. These are not accessible by default so several non-trivial steps must be taken to make them usable with VoiceOver.
* A view with a button and a label that can be shown and hidden using the button. With VoiceOver these two elements are separately accessible.
* A view with a button and a time progress. Without VoiceOver the progress bar grows from 0 to 1 within 20 seconds. With VoiceOver the progress is reported every five seconds.

