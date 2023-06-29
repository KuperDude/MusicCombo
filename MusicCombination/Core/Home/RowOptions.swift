//
//  RowOptions.swift
//  MusicCombination
//
//  Created by MyBook on 12.07.2022.
//

import Foundation
import SwiftUI

struct RowOptions: Shape {
    func path(in rect: CGRect) -> Path {
        let rectFrame = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.width / 2, height: rect.height)
        var p = Path(rectFrame)
        p.addEllipse(in: CGRect(x: 5, y: rectFrame.maxY / 4 - 3, width: rectFrame.midX, height: rectFrame.midX))
        p.addEllipse(in: CGRect(x: 5, y: rectFrame.maxY / 2 + 3, width: rectFrame.midX, height: rectFrame.midX))
        p.addEllipse(in: CGRect(x: rectFrame.midX, y: 0, width: rectFrame.midX, height: rectFrame.midX))
        p.addEllipse(in: CGRect(x: rectFrame.midX, y: rectFrame.maxY - (rectFrame.maxY / 4), width: rectFrame.midX, height: rectFrame.midX))
        return p
    }
}
