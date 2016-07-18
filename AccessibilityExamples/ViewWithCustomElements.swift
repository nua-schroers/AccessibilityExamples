//
//  ViewWithCustomElements.swift
//  AccessibilityExamples
//
//  Created by Dr. Wolfram Schroers on 3/1/15.
//  Copyright (c) 2015 Wolfram Schroers. All rights reserved.
//

import UIKit

/// This is a view with custom-drawn elements. These are not derived
/// from any UIKit objects and are therefore non-accessible. In order
/// to make them accessible, we must set the property
/// accessibilityElements (or, alternatively, adopt the other methods
/// from the UIAccessibilityContainer informal protocol).
///
/// The order of the elements matters and should go from top left to
/// bottom right.
class ViewWithCustomElements: CustomView {

    /// MARK: Override from UIView

    override func draw(_ rect: CGRect) {
        // View setup (nothing to do with Accessibility).

        // Draw the string "Hello" left-ish in this view.
        let someString = NSString(format: String("Hello"))
        someString.draw(at: CGPoint(x: 10, y: 10), withAttributes: nil)

        // Draw the string "World" right-ish in this view.
        let someOtherString = NSString(format: String("World"))
        let attribs: [String: AnyObject] = [NSForegroundColorAttributeName: UIColor.green()]
        someOtherString.draw(at: CGPoint(x: 120, y: 10), withAttributes: attribs)

        // Setup the accessibility container.
        self.setupContainer()
    }

    /// MARK: Setting up the Accessibility Container.

    func setupContainer() {
        // Instantiate proxies as a stand-in for the custom-drawn
        // elements.
        //
        // Note that this method would have to be called whenever the
        // screen changes, e.g. when the device is rotated. The
        // ViewController would be responsible for doing that since
        // drawRect may not be called again automatically.

        // Get the frame of the first string (in screen coordinates).
        let firstStringSize = NSString(format: String("Hello")).size(attributes: nil)
        let firstStringRect = CGRect(x: 10, y: 10, width: firstStringSize.width, height: firstStringSize.height)
        let firstStringFrame = self.convert(firstStringRect, to: nil)

        // Get the frame of the second string (in screen coordinates).
        let secondStringSize = NSString(format: String("World")).size(attributes: nil)
        let secondStringRect = CGRect(x: 120, y: 10, width: secondStringSize.width, height: secondStringSize.height)
        let secondStringFrame = self.convert(secondStringRect, to: nil)

        // Properly configure the stand-in for the custom-drawn string
        // "Hello". This works like any other "regular" view.
        let element1 = UIAccessibilityElement(accessibilityContainer: self)
        element1.accessibilityFrame = firstStringFrame
        element1.accessibilityLabel = "Shows Hello"
        element1.accessibilityTraits = UIAccessibilityTraitStaticText

        // Do the same for the second element, the stand-in for the
        // custom-drawn string "World".
        let element2 = UIAccessibilityElement(accessibilityContainer: self)
        element2.accessibilityFrame = secondStringFrame
        element2.accessibilityLabel = "Shows World"
        element2.accessibilityTraits = UIAccessibilityTraitStaticText

        // Set the accessbilityElements which turns this view into an
        // Accessibility Container.
        self.accessibilityElements = [element1, element2]
    }

    /// MARK: Setup method

    override func setup() {
        super.setup()

        // Accessibility setup.
        self.isAccessibilityElement = false

        // We don't need to do anything else since drawRect is
        // automatically called when needed.
    }

}
