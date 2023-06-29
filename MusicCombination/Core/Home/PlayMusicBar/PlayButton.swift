//
//  PlayButton.swift
//  MusicCombination
//
//  Created by MyBook on 12.07.2022.
//

import SwiftUI

struct PlayButton: View {
    
    @Binding var isPlaying: Bool
    var buttonAction: (() -> ())?
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.green)
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(.leading, isPlaying ? 0 : 5)
        }
        .frame(width: 60, height: 60)
        .onTapGesture {
            isPlaying.toggle()
            buttonAction?()
        }
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayButton(isPlaying: .constant(true))
            PlayButton(isPlaying: .constant(false))
            PlayButton(isPlaying: .constant(true))
                .preferredColorScheme(.dark)
            PlayButton(isPlaying: .constant(false))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
