//
//  MusicPlayEffect.swift
//  MusicCombination
//
//  Created by MyBook on 13.07.2022.
//

import SwiftUI

struct MusicPlayEffect: View {
    var index: Int
    @Binding var selectedIndex: Int?
    @State var refresh = false
    @Binding var isPlaying: Bool
    
    @State var timer = Timer.publish(every: 0.1, tolerance: 0.3, on: .main, in: .common)
    
    var body: some View {
        HStack(spacing: 3) {
            ForEach(0..<4) { _ in
                Rectangle()
                    .frame(width: 3, height: index == selectedIndex ? refresh ? CGFloat.random(in: 10...30) : CGFloat.random(in: 10...30) : 10)
            }
        }
        .opacity(index == selectedIndex ? 1 : 0)
        .foregroundColor(.white)
        .onReceive(timer) { _ in
            withAnimation {
                refresh.toggle()
            }
        }
        .onChange(of: isPlaying) { newValue in
            if newValue {
                timer = Timer.publish(every: 0.1, tolerance: 0.3, on: .main, in: .common)
                _ = timer.connect()
            } else {
                timer.connect().cancel()
            }
        }
    }
}

struct MusicPlayEffect_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayEffect(index: 1, selectedIndex: .constant(1), isPlaying: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
