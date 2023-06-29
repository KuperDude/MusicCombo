//
//  PreviewProvider.swift
//  MusicCombination
//
//  Created by MyBook on 11.07.2022.
//

import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    var musicVM = MusicViewModel()
    private init() { }

}


