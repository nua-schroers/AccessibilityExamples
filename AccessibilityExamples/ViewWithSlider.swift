//
//  ViewWithSlider.swift
//  AccessibilityExamples
//
//  Created by Dr. Wolfram Schroers on 3/1/15.
//  Copyright (c) 2015 Wolfram Schroers. All rights reserved.
//

import UIKit

/// This is a view which contains a description label and a slider.
/// The entire view shall be accessible and behave like a slider that
/// can be moved with the up/down swipe gestures.
///
/// Note that we do NOT want to access the individual sub-elements
/// (i.e., the label and the slider) individually when VoiceOver is
/// active. We only want to deal with the entire cell.
class ViewWithSlider: CustomView {

    /// MARK: Properties

    var textLabel = UILabel()
    var theSlider = UISlider()

    /// MARK: Private methods

    override func setup() {

        // View setup (nothing to do with Accessibility).
        self.textLabel.text = "Warp factor"
        self.textLabel.frame = CGRect(x: 5, y: 5, width: 200, height: 50)
        self.theSlider.frame = CGRect(x: 5, y: 55, width: 200, height: 50)
        self.theSlider.minimumValue = 0
        self.theSlider.maximumValue = 8
        self.addSubview(self.textLabel)
        self.addSubview(self.theSlider)

        // Accessibility setup.
        self.isAccessibilityElement = true            // The entire view shall be accessible.
        self.textLabel.isAccessibilityElement = false // But the individual elements (the label and the slider) shall not be.
        self.theSlider.isAccessibilityElement = false
        self.accessibilityLabel = "Warp factor"       // Give the entire view an appropriate VoiceOver label and hint.
        self.accessibilityHint = "Swipe up to speed up or down to slow down"

        // The entire view shall behave as an adjustible element,
        // i.e. it shall support and respond to swipe-up and -down
        // gestures.
        self.accessibilityTraits = UIAccessibilityTraits(rawValue: super.accessibilityTraits.rawValue | UIAccessibilityTraits.adjustable.rawValue)
        self.updateAccessibility()
    }

    override func updateAccessibility() {
        // Merely update the accessibility value of this view. It
        // shall be the actual value of the slider without further
        // interpretation.
        self.accessibilityValue = "\(self.theSlider.value)"
    }

    /// MARK: UIAccessibilityAction

    /// This method is automagically called when the user does a
    /// swipe-down while the view is highlighted.
    ///
    /// Note that this method is NOT used at all if VoiceOver is
    /// turned off!
    override func accessibilityDecrement() {
        // Respond to a swipe-down gesture.
        let warpFactor = Int(self.theSlider.value)
        if (warpFactor > 0) {
            self.theSlider.setValue(Float(self.theSlider.value-1), animated: false)
        } else {
            self.theSlider.setValue(self.theSlider.minimumValue, animated: false)
        }

        // Update the value.
        self.updateAccessibility()
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: "")
    }

    /// This method is automagically called when the user does a
    /// swipe-up while the view is highlighted.
    ///
    /// Note that this method is NOT used at all if VoiceOver is
    /// turned off!
    override func accessibilityIncrement() {
        // Respond to a swipe-up gesture.
        let warpFactor = Int(self.theSlider.value)
        if (warpFactor < 8) {
            self.theSlider.setValue(Float(self.theSlider.value+1), animated: false)
        } else {
            self.theSlider.setValue(self.theSlider.maximumValue, animated: false)
        }

        // Update the value.
        self.updateAccessibility()
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: "")
    }

}

