//
//  MusicDropDelegate.swift
//  MusicCombination
//
//  Created by MyBook on 20.07.2022.
//

import SwiftUI


struct MusicDropDelegate: DropDelegate {

    let item: Music
    @Binding var items: [Music]
    @Binding var draggedItem: Music?
    var vm: MusicViewModel

    func performDrop(info: DropInfo) -> Bool {
        vm.updateIndices()
        //draggedItem = Music(name: "", soundData: Data(), duration: "", icon: Data())
        return true
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func dropEntered(info: DropInfo) {
        guard let draggedItem = self.draggedItem else {
            return
        }

        if draggedItem.id != item.id {
            let from = items.firstIndex(where: { $0.id == draggedItem.id })!
            let to = items.firstIndex(where: { $0.id == item.id })!
            HapticManager.impact(style: .light)
            vm.moveAtIndexOffSet(indexSet: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
        }
    }
//    func dropExited(info: DropInfo) {
//        vm.resetDragItem(to: item)
//    }
}
