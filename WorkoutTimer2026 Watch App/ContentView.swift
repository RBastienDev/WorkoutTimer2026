//
//  ContentView.swift
//  WorkoutTimer2026 Watch App
//
//  Created by Robert Bastien on 2026-06-15.
//

import SwiftUI
import UserNotifications
import WatchKit

struct ContentView: View {
	
		@StateObject private var timerManager = TimerManager()
		private let lastPresetKey = "lastSelectedPresetIndex"
		private let lastCustomTimeKey = "lastCustomTimeSeconds"
	
		// presets
	let presets: [TimeInterval] = [60, 5*60, 10*60, 20*60, 30*60]
	let presetLabels: [String] = ["1m", "5m", "10m","20m","30m"]
	
	@State private var selectedPresetIndex: Int = {
		let saved = UserDefaults.standard.object(forKey: "lastSelectedPresetIndex")
		as? Int
		return saved ?? 1
	}()
	
	// Custom timer
	@State private var ShowingCustomTimeSheet = false
	@State private var customMinutes: Int = 1
	@State private var custimSeconds: Int = 0
	
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
