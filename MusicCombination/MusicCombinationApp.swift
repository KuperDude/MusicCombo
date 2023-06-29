//
//  MusicCombinationApp.swift
//  MusicCombination
//
//  Created by MyBook on 11.07.2022.
//

import SwiftUI
import AVFAudio

@main
struct MusicCombinationApp: App {
    @StateObject var vm = MusicViewModel()

    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowAirPlay, .allowBluetooth])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
    }
    
    var body: some Scene {
        
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
