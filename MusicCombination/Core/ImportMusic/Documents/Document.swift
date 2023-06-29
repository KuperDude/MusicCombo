//
//  Document.swift
//  MusicCombination
//
//  Created by MyBook on 11.07.2022.
//

import Foundation
import SwiftUI
import AVFAudio

struct Document: UIViewControllerRepresentable {
    @EnvironmentObject var vm: MusicViewModel
    
    func makeCoordinator() -> Coordinator {
        Coordinator(document: self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentController = UIDocumentPickerViewController(forOpeningContentTypes: [.audio, .mp3])
        documentController.allowsMultipleSelection = true
        documentController.delegate = context.coordinator
        return documentController
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var document: Document
        
        init(document: Document) {
            self.document = document
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {

            guard let url = urls.first else { return }
            
            if url.startAccessingSecurityScopedResource() {
                do {
                    let data = try Data(contentsOf: url)
                    document.vm.addMusic(name: url.deletingPathExtension().lastPathComponent, soundData: data, icon: Data())
                } catch {
                    print("something wrong \(error)")
                }
            }
            url.stopAccessingSecurityScopedResource()
            
            
        }
    }
}
