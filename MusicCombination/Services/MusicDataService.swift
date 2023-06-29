//
//  MusicDataService.swift
//  MusicCombination
//
//  Created by MyBook on 15.07.2022.
//

import Foundation
import CoreData

class MusicDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "MusicContainer"
    private let entityName = "MusicEntity"
    
    @Published var musics: [MusicEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if error != nil {
                print("some error with core data \(String(describing: error))")
            }
            
            self.getMusics()
        }
    }
    
    private func getMusics() {
        let request = NSFetchRequest<MusicEntity>(entityName: entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        do {
            self.musics = try container.viewContext.fetch(request)
        } catch {
            print("some error with core data \(error)")
        }
    }
    
    func add(name: String, soundData: Data, icon: Data, id: String, index: Int) {
        let entity = MusicEntity(context: container.viewContext)
        entity.icon = icon
        entity.name = name
        entity.soundData = soundData
        entity.id = id
        entity.index = Int32(index)
        applyChanges()
    }
    
    func update(id: String, name: String, icon: Data, index: Int) {
        guard let entity = musics.first(where: { id == $0.id }) else { return }
        entity.name = name
        entity.icon = icon
        entity.index = Int32(index)
        applyChanges()
    }
    
    func delete(id: String) {
        guard let entity = musics.first(where: { id == $0.id }) else { return }
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    func updateIndices(musics musicss: [Music]) {
        for (i, value) in musicss.enumerated() {
            self.musics.first(where: { value.id == $0.id })?.index = Int32(i)
        }
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getMusics()
    }
}
