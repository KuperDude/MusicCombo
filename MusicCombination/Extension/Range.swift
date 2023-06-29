//
//  Range.swift
//  MusicCombination
//
//  Created by MyBook on 18.07.2022.
//

import Foundation

extension Range {
    /// If item == nil then return false
    func contains(_ item: Bound?) -> Bool {
        if item == nil {
            return false
        } else {
            return self.contains(item!)
        }
    }
}
