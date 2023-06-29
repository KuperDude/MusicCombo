//
//  RedactImportFileView.swift
//  MusicCombination
//
//  Created by MyBook on 22.07.2022.
//

import SwiftUI

struct RedactImportFileView: View {
    @State var musicTitle = "some music"
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    @State var startingDragOffsetY: CGFloat = UIScreen.main.bounds.height - 300
    @Binding var isPresent: Bool
    
    var body: some View {
        
        ZStack(alignment: .top) {
            //background
            Color.gray
                .cornerRadius(20)
            
            //body
            VStack {
                Capsule(style: .continuous)
                    .frame(width: 30, height: 5, alignment: .top)
                    .padding(.top, 10)
                Rectangle()
                    .foregroundColor(.red)
                    .frame(height: 100)
                
                optionBar
            }
        }
        .offset(y: startingDragOffsetY)
        .offset(y: endingOffsetY)
        .offset(y: currentDragOffsetY)
        .gesture(
            DragGesture()
//                .updating($currentDragOffsetY, body: { value, currentDragOffsetY, _ in
//                    withAnimation(.spring()) {
//                        currentDragOffsetY = value.translation.height
//                    }
//                })
                .onChanged { value in
                    withAnimation(.spring()) {
                        if value.translation.height < 0 && endingOffsetY == -startingDragOffsetY {
                            currentDragOffsetY = 0
                        } else {
                            currentDragOffsetY = value.translation.height
                        }
                    }
                }
                .onEnded { _ in
                    withAnimation(.spring()) {
                        if currentDragOffsetY < -150 {
                            endingOffsetY = -startingDragOffsetY
                        } else if currentDragOffsetY > startingDragOffsetY {
                            isPresent = false
                        } else if currentDragOffsetY != 0 && currentDragOffsetY > 150 && endingOffsetY != 0 {
                            endingOffsetY = 0
                        } else if currentDragOffsetY > 160 && endingOffsetY == 0 {
                            isPresent = false
                        }
                        currentDragOffsetY = 0
                    }
                }
        )
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct RedactImportFileView_Previews: PreviewProvider {
    static var previews: some View {
        RedactImportFileView(isPresent: .constant(true))
    }
}

extension RedactImportFileView {
    var optionBar: some View {
        HStack {
            Image(systemName: "arrow.down.to.line")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
            Spacer()
            Image(systemName: "backward.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 25)
            Spacer()
            Image(systemName: "pause.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
            Spacer()
            Image(systemName: "forward.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 25)
            Spacer()
            Image(systemName: "arrow.down.to.line")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                
        }
        .padding(.horizontal)
    }
}
