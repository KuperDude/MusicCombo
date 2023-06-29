//
//  MusicViewModel.swift
//  MusicCombination
//
//  Created by MyBook on 11.07.2022.
//

import Foundation
import Combine

class MusicViewModel: ObservableObject {
    
    @Published var musics = [Music]()
    
    @Published var draggedItem: Music?

    @Published var isPlaying = false {
        didSet {
            if isPlaying {
                MusicManager.player?.play()
            } else {
                MusicManager.player?.pause()
            }
        }
    }
    
    @Published var selectedIndex: Int? = nil {
        didSet {
            guard let index = selectedIndex else { return }
            if index >= self.musics.count {
                self.selectedIndex = 0
                return
            } else if index == -1 {
                self.selectedIndex = self.musics.count - 1
                return
            }
            if MusicManager.player?.data != self.musics[index].soundData {
                MusicManager.play(data: self.musics[index].soundData)
            }
        }
    }
    
    var musicDataService = MusicDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // toggle music
        NotificationCenter.default.addObserver(forName: .AudioPlayerDidFinishPlaying, object: nil, queue: .main) { _ in
            if self.selectedIndex != nil {
                self.selectedIndex! += 1
            }
        }
        
        // get music
        musicDataService.$musics
            .map(entitiesToMusic)
            .sink { musics in
                self.musics = musics
            }
            .store(in: &cancellables)
    }
    
    private func entitiesToMusic(musicEntities: [MusicEntity]) -> [Music] {
        let musics = musicEntities.map { $0.toMusic() }
        return musics
    }
    
    //MARK: User Intent(s)
    
    func addMusic(name: String, soundData: Data, icon: Data) {
        musicDataService.add(name: name, soundData: soundData, icon: icon, id: UUID().uuidString, index: musics.count)
    }
    
    func moveAtIndexOffSet(indexSet: IndexSet, toOffset: Int) {
        let selectedId = musics.indices.contains(selectedIndex) ? musics[selectedIndex!].id : ""
        
        musics.move(fromOffsets: indexSet, toOffset: toOffset)
        selectedIndex = musics.firstIndex(where: { $0.id == selectedId })
        //musicDataService.updateIndices(musics: musics)
    }
    
    func updateIndices() {
        musicDataService.updateIndices(musics: musics)
    }
    
    func remove(at index: Int) {
        let selectedId = musics.indices.contains(selectedIndex) ? musics[selectedIndex!].id : ""
        musicDataService.delete(id: musics[index].id)
        selectedIndex = musics.firstIndex(where: { $0.id == selectedId })
        if selectedIndex == nil {
            resetMusic()
        }
        musicDataService.updateIndices(musics: musics)
    }
    
    private func resetMusic() {
        isPlaying = false
        MusicManager.player = nil
    }
    
    func updateIfNeed(at index: Int) {
        if musics[index] != musicDataService.musics[index].toMusic() {
            musicDataService.update(id: musics[index].id, name: musics[index].name, icon: musics[index].icon, index: index)
        }
    }
    
    func resetDragItem(to item: Music) {
        draggedItem = musics[selectedIndex ?? 0]
        //draggedItem = item
    }
}
