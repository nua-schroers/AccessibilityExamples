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

    var expandButton:UIButton = UIButton(type:.System) as UIButton
    var moreTextLabel = UILabel(frame: CGRectMake(5, 30, 200, 120))

    /// MARK: Private methods

    override func setup() {
        super.setup()

        // View setup (nothing to do with Accessibility).
        self.expandButton.frame = CGRectMake(5, 5, 100, 20)
        self.expandButton.setTitle("Details", forState: .Normal)
        self.expandButton.addTarget(self, action: #selector(ExpandableView.userDidPressExpand), forControlEvents: .TouchUpInside)
        self.moreTextLabel.text = "Paragraph 1\nblablabla\n...\nParagraph 524\nblablabla"
        self.moreTextLabel.numberOfLines = 0
        self.moreTextLabel.lineBreakMode = .ByWordWrapping
        self.moreTextLabel.hidden = false
        self.addSubview(self.moreTextLabel)
        self.addSubview(self.expandButton)

        // Accessibility setup.
        self.isAccessibilityElement = false                                               // The entire view shall not be accessible.
        self.expandButton.accessibilityLabel = "Details"                                  // The button shall be accessible individually.
        self.expandButton.accessibilityHint = "Double tap to collapse and expand details" // Hint for what to do.
        // The text label is accessible by default if it is not hidden.
    }

    /// MARK: Respond to button

    func userDidPressExpand() {
        // Hide or unhide the text label.
        self.moreTextLabel.hidden = !self.moreTextLabel.hidden

        // Post a notification that the layout has changed.
        UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, "")
    }

}
