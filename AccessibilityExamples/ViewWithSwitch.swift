//
//  ViewWithSwitch.swift
//  AccessibilityExamples
//
//  Created by Dr. Wolfram Schroers on 3/1/15.
//  Copyright (c) 2015 Wolfram Schroers. All rights reserved.
//

import UIKit

/// This is a view which contains a description label and a switch.
/// The entire view shall be accessible and behave like a switch that can be
/// turned.
///
/// Note that we do NOT want to access the individual sub-elements
/// (i.e., the label and the switch) individually when VoiceOver is active. We only want to deal with
/// the entire cell.
class ViewWithSwitch: CustomView {

    /// MARK: Properties

    var textLabel = UILabel()
    var theSwitch = UISwitch()

    /// MARK: Configuration methods

    override func setup() {
        super.setup()

        // View setup (nothing to do with Accessibility).
        let powerSettingText = NSLocalizedString("Power setting", comment: "")
        self.textLabel.text = powerSettingText
        self.textLabel.frame = CGRect(x: 5, y: 5, width: 200, height: 50)
        self.theSwitch.frame = CGRect(x: 205, y: 5, width: 50, height: 50)
        self.addSubview(self.textLabel)
        self.addSubview(self.theSwitch)

        // Accessibility setup.
        self.isAccessibilityElement = true            // The entire view shall be accessible.
        self.textLabel.isAccessibilityElement = false // But the label and the switch shall not be.
        self.theSwitch.isAccessibilityElement = false
        self.accessibilityLabel = powerSettingText    // This is the standard label text of this view.
        self.accessibilityHint = "Double tap to activate or deactivate" // This is the hint.

        // This view shall behave as a button with VoiceOver.
        self.accessibilityTraits = UIAccessibilityTraits(rawValue: super.accessibilityTraits.rawValue | UIAccessibilityTraits.button.rawValue)

        self.updateAccessibility()
    }

    override func updateAccessibility() {
        super.updateAccessibility()

        // The value is the current setting and we use a custom text here.
        self.accessibilityValue = self.theSwitch.isOn ? "active" : "inactive"
    }

    /// MARK: UIAccessibilityAction

    /// This method is automagically called when the user double-taps
    /// while the view is highlighted.
    ///
    /// Note that this method is NOT used at all if VoiceOver is
    /// turned off!
    override func accessibilityActivate() -> Bool {
        // Toggle the switch.
        let newValue = !self.theSwitch.isOn
        self.theSwitch.setOn(newValue, animated: true)

        // Update the accessibility value.
        self.updateAccessibility()

        // Inform the user of the new situation.
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: "")

        // Return whether the action was successful (in this case is it always is).
        return true
    }

}
