//
//  TimeInterval.swift
//  MusicCombination
//
//  Created by MyBook on 12.07.2022.
//

import Foundation

extension TimeInterval {
    ///Formatted TimeInterval to String
    /// ```
    /// 0.0 -> "0:00"
    /// 100.0 -> "1:40"
    /// 600.0 -> "10:00"
    /// 10_450.0 -> "2:54:10"
    /// 100_844.0 -> "1d 4:00:44"
    /// ```
    ///
    func toFormattedString() -> String {
        let formatter = DateComponentsFormatter()
        if formatter.string(from: self)?.count == 2 {
            return "0:" + (formatter.string(from: self) ?? "0:00")
        } else if formatter.string(from: self)?.count == 1 {
            return "0:0" + (formatter.string(from: self) ?? "0:00")
        }
        
        return formatter.string(from: self) ?? "0:00"

    }
}
