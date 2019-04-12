//
//  ExpandableView.swift
//  AccessibilityExamples
//
//  Created by Dr. Wolfram Schroers on 3/1/15.
//  Copyright (c) 2015 Wolfram Schroers. All rights reserved.
//

import UIKit

/// This is a view which contains a button and a multi-line text
/// label. The shows and hides the label when tapped. The individual
/// button and the text label shall be accessible (the latter only if
/// it is not hidden).
class ExpandableView: CustomView {

    /// MARK: Properties

    var expandButton:UIButton = UIButton(type:.system) as UIButton
    var moreTextLabel = UILabel(frame: CGRect(x: 5, y: 30, width: 200, height: 120))

    /// MARK: Private methods

    override func setup() {
        super.setup()

        // View setup (nothing to do with Accessibility).
        self.expandButton.frame = CGRect(x: 5, y: 5, width: 100, height: 20)
        self.expandButton.setTitle("Details", for: UIControl.State())
        self.expandButton.addTarget(self, action: #selector(ExpandableView.userDidPressExpand), for: .touchUpInside)
        self.moreTextLabel.text = "Paragraph 1\nblablabla\n...\nParagraph 524\nblablabla"
        self.moreTextLabel.numberOfLines = 0
        self.moreTextLabel.lineBreakMode = .byWordWrapping
        self.moreTextLabel.isHidden = false
        self.addSubview(self.moreTextLabel)
        self.addSubview(self.expandButton)

        // Accessibility setup.
        self.isAccessibilityElement = false                                               // The entire view shall not be accessible.
        self.expandButton.accessibilityLabel = "Details"                                  // The button shall be accessible individually.
        self.expandButton.accessibilityHint = "Double tap to collapse and expand details" // Hint for what to do.
        // The text label is accessible by default if it is not hidden.
    }

    /// MARK: Respond to button

    @IBAction func userDidPressExpand() {
        // Hide or unhide the text label.
        self.moreTextLabel.isHidden = !self.moreTextLabel.isHidden

        // Post a notification that the layout has changed.
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: "")
    }

}
