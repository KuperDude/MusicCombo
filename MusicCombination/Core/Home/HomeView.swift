//
//  HomeView.swift
//  MusicCombination
//
//  Created by MyBook on 11.07.2022.
//

import SwiftUI
import AVFAudio

struct HomeView: View {
    @Environment(\.editMode) private var editMode
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    
    @EnvironmentObject var vm: MusicViewModel
    @Namespace var text
    
    @State var isTapOnCell = false
    
    @State var isOpenDocuments = false
    
    var body: some View {
        ZStack {
            //background
            Wave()
                .fill(
                    LinearGradient(colors: [.cyan, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .ignoresSafeArea()
            
            //body
            VStack {
                topSection
                musicList
            }
            
            playMusicBar
            
            if isTapOnCell {
                RedactImportFileView(isPresent: $isTapOnCell)
                    .transition(.move(edge: .bottom))
            }
        }
        .sheet(isPresented: $isOpenDocuments, content: {
            Document()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(MusicViewModel())
    }
}

extension HomeView {
    var topSection: some View {
        HStack {
            EditButton()
            Spacer()
            Button {
                isOpenDocuments.toggle()
            } label: {
                Image(systemName: "plus")
                    .frame(width: 40, height: 40)
            }
        }
        .padding(.horizontal)
    }
    
    var musicList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(vm.musics.indices, id: \.self) { index in
                    MusicRowView(index: index, isPlaying: $vm.isPlaying)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .onTapGesture {
                            if self.editMode?.wrappedValue != .active {
                                timer.connect().cancel()
                                timer = Timer.publish(every: 1, on: .main, in: .common)
                                _ = timer.connect()
                                
                                if index != vm.selectedIndex {
                                    vm.selectedIndex = index
                                    vm.isPlaying = true
                                } else {
                                    vm.isPlaying.toggle()
                                    // isTapOnCell = true
                                }
                            }
                        }
                        .matchedGeometryEffect(id: vm.musics[index].id, in: text)
                        .onDrag({
                            vm.draggedItem = vm.musics[index]
                            return NSItemProvider(object: vm.musics[index].id as NSString)
                        })
                        .onDrop(of: [.text], delegate: MusicDropDelegate(item: vm.musics[index], items: $vm.musics, draggedItem: $vm.draggedItem, vm: vm))
                        .animation(.easeOut, value: vm.musics.description)
                }
            }
        }
        
        
//        List {
//            ForEach(vm.musics.indices, id: \.self) { index in
//                MusicRowView(index: index, isPlaying: $vm.isPlaying)
//                    .onTapGesture {
//                        if self.editMode?.wrappedValue != .active {
//                            timer.connect().cancel()
//                            timer = Timer.publish(every: 1, on: .main, in: .common)
//                            _ = timer.connect()
//
//                            if index != vm.selectedIndex {
//                                vm.selectedIndex = index
//                                vm.isPlaying = true
//                            } else {
//                                vm.isPlaying.toggle()
//                            }
//                        }
//                    }
//
//            }
//            .onMove(perform: vm.moveAtIndexOffSet)
//            .onDelete(perform: vm.removeAtIndexOffSet)
//        }
//        .listStyle(.plain)
    }
    
    var playMusicBar: some View {
        VStack {
            Spacer()
            ZStack(alignment: .trailing) {
                MusicSlider(timer: $timer)
                    .opacity(MusicManager.player != nil ? 1 : 0)
                PlayButton(isPlaying: $vm.isPlaying) {
                    if MusicManager.player == nil {
                        if !vm.musics.isEmpty {
                            timer.connect().cancel()
                            timer = Timer.publish(every: 1, on: .main, in: .common)
                            _ = timer.connect()
                            
                            vm.selectedIndex = 0
                        } else {
                            vm.isPlaying = false
                        }
                    }
                }
            }
        }
    }
}
