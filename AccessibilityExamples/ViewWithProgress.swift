//
//  ViewWithProgress.swift
//  AccessibilityExamples
//
//  Created by Dr. Wolfram Schroers on 3/29/15.
//  Copyright (c) 2015 Wolfram Schroers. All rights reserved.
//

import UIKit

/// This is a view which contains a button and a progress bar. The
/// button starts a 20-second countdown that shall be both accessible
/// to VoiceOver and visually. The VoiceOver announcement is always
/// active, regardless of which element the user has selected.
///
/// The progress bar itself is not accessible. Instead, the updated
/// values are read by VoiceOver only. This may or may not be what the
/// user expects. In general, for a true self-destruction this may be
/// acceptible. But in other cases such a global notification may not
/// be the user expectation.
class ViewWithProgress: CustomView {

    /// MARK: Properties

    var startButton:UIButton = UIButton(type:.System) as UIButton
    var progressBar = UIProgressView(progressViewStyle: .Default)

    var destructionTimer:NSTimer?
    var destructionProgress = 0.0

    /// MARK: Private methods

    override func setup() {
        super.setup()

        // View setup (nothing to do with Accessibility).
        self.startButton.frame = CGRectMake(5, 5, 100, 20)
        self.startButton.setTitle("Selfdestruct", forState: .Normal)
        self.startButton.addTarget(self, action: "userDidPressSelfdestruct", forControlEvents: .TouchUpInside)
        self.progressBar.frame = CGRectMake(5, 30, 200, 20)
        self.progressBar.progress = 0.0
        self.addSubview(self.progressBar)
        self.addSubview(self.startButton)

        // Accessibility setup.
        self.progressBar.isAccessibilityElement = false // The progress bar shall not be accessible.

        // But the button is accessible by default and we give it a
        // proper label and hint.
        self.startButton.accessibilityLabel = "Trigger self destruction sequence"
        self.startButton.accessibilityHint = "Double tap to trigger the self destruction sequence"

        // The entire view (as a subclass of UIView) is not accessible by
        // default.
    }

    /// MARK: Respond to button

    func userDidPressSelfdestruct() {
        self.startButton.enabled = false
        self.resetTimer()

        // Instantiate and trigger a timer that fires every 0.5
        // seconds.
        let countdownTimer = NSTimer.scheduledTimerWithTimeInterval(0.5,
            target: self,
            selector: "progressing",
            userInfo: nil,
            repeats: true)
        self.destructionTimer = countdownTimer
    }

    /// MARK: Reset and handle program progress

    func resetTimer () {
        // Reset the progress bar und the model value.
        self.destructionProgress = 0.0
        self.progressBar.progress = 0.0

        // Invalidate the timer (if needed).
        if self.destructionTimer != nil {
            self.destructionTimer?.invalidate()
            self.destructionTimer = nil
        }
    }

    func progressing() {
        // Increase progress (data model only).
        self.destructionProgress += 0.5

        // Trigger VoiceOver notification every five seconds or reset
        // after 25 seconds.
        switch (self.destructionProgress) {
        case _ where fabs(destructionProgress - 5.0) < 0.1:
            UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, "15 seconds remaining")
        case _ where fabs(destructionProgress - 10.0) < 0.1:
            UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, "10 seconds remaining")
        case _ where fabs(destructionProgress - 15.0) < 0.1:
            UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, "5 seconds remaining")
        case _ where fabs(destructionProgress - 20.0) < 0.1:
            UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, "Selfdestruct completed")
        case _ where destructionProgress > 25.0 :
            self.resetTimer()
            self.startButton.enabled = true
            UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, "Alive again")
        default:
            break
        }

        // Update the progress bar (in the UI only, does not affect
        // VoiceOver).
        self.progressBar.progress = Float(self.destructionProgress / 20.0)
    }
    
}
