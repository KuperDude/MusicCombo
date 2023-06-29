//
//  MusicEntity.swift
//  MusicCombination
//
//  Created by MyBook on 20.07.2022.
//

import Foundation

extension MusicEntity {
    func toMusic() -> Music {
        return Music(id: self.id ?? "", name: self.name ?? "<<Error>>", soundData: self.soundData ?? Data(), duration: MusicManager.duration(data: self.soundData ?? Data())?.toFormattedString() ?? "", icon: self.icon ?? Data())
    }
}
