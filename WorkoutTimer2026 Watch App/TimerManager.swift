//
//  TimerManager.swift
//  WorkoutTimer2026 Watch App
//
//  Created by Robert Bastien on 2026-06-15.
//

import Foundation
import Combine
import UserNotifications
import WatchKit

@MainActor
final class TimerManager: ObservableObject {
	
		// MARK: - Published for UI
		@Published private(set) var duration: TimeInterval // total seconds for a current session
		@Published private(set) var remaining: TimeInterval // remaining seconds for a current session
		@Published private(set) var isRunning: Bool = false
		@Published private(set) var progress: Double = 0.0 // 0.0 - 1.0 allowable range
	
		// MARK: - Config
		private var timerTask: Task<Void, Never>? = nil
	
		init(duration: TimeInterval = 60) {
			self.duration = duration
			self.remaining = duration
			self.updateProgress()
	}
	
		// MARK: - Public API
		
	func setDuration(_ seconds: TimeInterval){
		guard !isRunning else { return } // change only when paused or stopped
		duration = max(1, seconds)
		remaining = duration
		updateProgress()
	}
	
		// MARK: - Private timer loop
	
	private func updateProgress(){
		if duration <= 0 {
				progress = 0
		}
		else {
			progress = max (0, min(1.0, 1.0 - (remaining/duration)))
		}
	}
	
		// MARK: - Notifications
	
	
		// MARK: - Helpers
	
}
