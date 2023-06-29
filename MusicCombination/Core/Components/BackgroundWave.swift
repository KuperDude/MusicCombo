//
//  BackgroundWave.swift
//  MusicCombination
//
//  Created by MyBook on 23.08.2022.
//

import SwiftUI

struct Wave: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY), control: CGPoint(x: rect.width * 0.2, y: rect.height * 0.4))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY), control: CGPoint(x: rect.width * 0.8, y: rect.height * 0.6))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}
