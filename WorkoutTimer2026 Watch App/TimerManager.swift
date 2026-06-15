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
	
	func start(){
		guard !isRunning else { return }
		isRunning = true
		scheduleCompletionNotification()
		timerTask = Task{
				[weak self] in
				await self?.runTimerLoop()
		}
	}
	
	func pause(){
		guard isRunning else { return }
		isRunning = false
		timerTask?.cancel()
		timerTask = nil
		removePendingCompletionNotification()
	}
	
	func reset(){
		isRunning = false
		timerTask?.cancel()
		timerTask = nil
		remaining = duration
		updateProgress()
		removePendingCompletionNotification()
	}
	
	func toggle(){
		isRunning ? pause() : start()
	}
	
	private func playCountdownHaptic(){
		// Use a light tap for countdown
		WKInterfaceDevice.current().play(.notification)
	}
	
		// MARK: - Private timer loop
	
	private func runTimerLoop() async {
			let startDate = Date()
			var lastTick = startDate
		while isRunning && remaining > 0 {
			do {
				try await Task.sleep(nanoseconds: 250_000_000) // 0.25s ticks
			}
			catch {
				break // cancelled
			}
			
			let now = Date()
			
			let elapsed = now.timeIntervalSince(lastTick)
			if elapsed >= 1.0 {
				
			}
		}
	}
	
		private func updateProgress(){
			if duration <= 0 {
					progress = 0
			}
			else {
				progress = max (0, min(1.0, 1.0 - (remaining/duration)))
			}
		}
	
		
	
		// MARK: - Notifications
	
		private func scheduleCompletionNotification(){
			
		}
	
		private func removePendingCompletionNotification(){
			UNUserNotificationCenter.current().removeAllPendingNotificationRequests(withIdentifiers: ["WorkoutTimerCompletion"])
		}
	
		// MARK: - Helpers
	
}
