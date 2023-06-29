//
//  MusicPlayer.swift
//  MusicCombination
//
//  Created by MyBook on 11.07.2022.
//

import Foundation
import AVFAudio
import SwiftUI

class MusicManager {
    
    static let delegate = MusicManagerDelegate()
    
    static var player: AVAudioPlayer?
    
    static func play(data: Data) {
        do {
            player = try AVAudioPlayer(data: data)
            player?.delegate = delegate
            
            if let player = player {
                if player.isPlaying {
                    player.stop()
                }
                player.play()
            }
            
        } catch {
            print("something wrong \(error)")
        }
    }
    
    static func duration(data: Data) -> TimeInterval? {
        do {
            let customPlayer = try AVAudioPlayer(data: data)
            return customPlayer.duration
        } catch {
            print("something wrong \(error)")
        }
        return nil
    }
}

class MusicManagerDelegate: NSObject, AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        MusicManager.player = nil
        NotificationCenter.default.post(name: .AudioPlayerDidFinishPlaying, object: nil)
    }
    
}
