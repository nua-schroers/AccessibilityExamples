//
//  CustomView.swift
//  AccessibilityExamples
//
//  Created by Dr. Wolfram Schroers on 3/1/15.
//  Copyright (c) 2015 Wolfram Schroers. All rights reserved.
//

import UIKit

/// This is the base class for the custom views whose content shall be
/// made accessible.
class CustomView: UIView {

    /// Initializers for the various cases (we only need the second
    /// one for this example app).
    ///
    /// These initializers should not be overridden.

    override init() {
        super.init()
        self.setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    /// MARK: Setup helper methods (should be overridden)

    /// General setup method. Creates and configures all child views
    /// and configures VoiceOver.
    func setup() {
    }

    /// Helper method to be used whenever content changes.
    func updateAccessibility() {
    }

}
