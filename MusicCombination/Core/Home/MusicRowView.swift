//
//  MusicRowView.swift
//  MusicCombination
//
//  Created by MyBook on 11.07.2022.
//

import SwiftUI

struct MusicRowView: View {
    @EnvironmentObject var vm: MusicViewModel
    @Environment(\.editMode) private var editMode

    var index: Int
    @Binding var isPlaying: Bool
    
    var body: some View {
        if vm.musics.count != 0 {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            AngularGradient(colors: [.white, Color("Light")], center: .topLeading, angle: Angle(degrees: 90 + 45))
                        )
                        .frame(width: 50, height: 50)
                        .opacity(min(vm.musics.count - 1, index) == vm.selectedIndex ? 0.8 : 1)
                    MusicPlayEffect(index: min(vm.musics.count - 1, index), selectedIndex: $vm.selectedIndex, isPlaying: $isPlaying)
                }
                //if self.editMode?.wrappedValue == .active {
                TextField("music title", text: $vm.musics[min(vm.musics.count - 1, index)].name)
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .lineLimit(1)
                    .disabled(self.editMode?.wrappedValue != .active)
                //}
//                else {
//                    Text(vm.musics[index].name)
//                        .font(.system(size: 20, weight: .semibold, design: .default))
//                        .lineLimit(1)
//                }
                Spacer()
//                RowOptionss()
//                    .frame(width: 50, height: 50)
                //min(vm.musics.count - 1, index)
                if self.editMode?.wrappedValue == .active {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .onTapGesture {
                            vm.remove(at: min(vm.musics.count - 1, index))
                        }
                } else {
                    Text(vm.musics[min(vm.musics.count - 1, index)].duration)
                        .fontWeight(.light)
                }
                
                    
            }
            .contentShape(Rectangle())
//            min(vm.musics.count - 1, index)
//            .onAppear {
//                musicTitle = vm.musics[min(vm.musics.count - 1, index)].name
//            }
//            .onChange(of: vm.musics[min(vm.musics.count - 1, index)].name, perform: { newValue in
//                musicTitle = newValue
//            })
            .onChange(of: editMode?.wrappedValue) { _ in
                vm.updateIfNeed(at: min(vm.musics.count - 1, index))
            }
            
        }
    }
}

struct MusicRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MusicRowView(index: 0, isPlaying: .constant(true))
                .environmentObject(MusicViewModel())
            MusicRowView(index: 0, isPlaying: .constant(true))
                .preferredColorScheme(.dark)
                .environmentObject(MusicViewModel())
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
