//
//  Music.swift
//  MusicCombination
//
//  Created by MyBook on 11.07.2022.
//
import Foundation

struct Music: Codable, Identifiable, Equatable {
    var id = UUID().uuidString
    var name: String
    let soundData: Data
    let duration: String
    let icon: Data
}
