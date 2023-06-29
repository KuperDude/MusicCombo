//
//  MusicSlider.swift
//  MusicCombination
//
//  Created by MyBook on 12.07.2022.
//

import SwiftUI

struct MusicSlider: View {
    @EnvironmentObject var vm: MusicViewModel
    @Binding var timer: Timer.TimerPublisher
    @State var currentSliderMusicTime = 0.0
    
    var body: some View {
        ZStack {
            Capsule(style: .continuous)
                .fill(
                    LinearGradient(colors: [.yellow, .green], startPoint: .leading, endPoint: .trailing)
                )
                
            HStack {
                Image(systemName: "backward.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        if vm.selectedIndex != nil {
                            vm.selectedIndex! -= 1
                            vm.isPlaying = true
                        }
                    }
                
                Slider(value: $currentSliderMusicTime, in: 0...(MusicManager.player?.duration ?? TimeInterval(100)), onEditingChanged: { bool in
                        if !bool {
                            MusicManager.player?.currentTime = currentSliderMusicTime
                            timer = Timer.publish(every: 1, on: .main, in: .common)
                            _ = timer.connect()
                        } else {
                            timer.connect().cancel()
                        }
                    })
                .tint(.white)
                
                Image(systemName: "forward.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 50)
                    .onTapGesture {
                        if vm.selectedIndex != nil {
                            vm.selectedIndex! += 1
                            vm.isPlaying = true
                        }
                    }
            }
            .padding(.horizontal)
        }
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width / 1.2, height: 40)
        .onReceive(timer, perform: { time in
            if MusicManager.player?.currentTime == nil {
                timer.connect().cancel()
            }
            withAnimation(.linear) {
                currentSliderMusicTime = MusicManager.player?.currentTime ?? TimeInterval(0)
            }
        })
    }
}

struct MusicSlider_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MusicSlider(timer: .constant(Timer.TimerPublisher(interval: 1, runLoop: .main, mode: .common)))
            MusicSlider(timer:.constant(Timer.TimerPublisher(interval: 1, runLoop: .main, mode: .common)))
                .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
