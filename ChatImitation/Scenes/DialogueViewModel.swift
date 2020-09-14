//
//  DialogueViewModel.swift
//  ChatImitation
//
//  Created by Dmitry Kuklin on 08.09.2020.
//

import SwiftUI

class DialogueViewModel: ObservableObject {
    @Published private(set) var dialogueLines = [DialogueLineModel]()
    @Published private(set) var error = ""
    
    private var dialogModel: DialogueModel = DialogueModel(dialogue: [DialogueLineModel]())
    private let jSonService: JSonService = JSonService()
    
    private var activeLineIndex = 0
    
    func getDialogue() {
        jSonService.readDialogJson { [weak self] (dialogue) in
            self?.dialogModel = dialogue
        } failure: { [weak self] (error) in
            self?.error = error.debugDescription
        }
    }
    
    func imitationOfChatActivity() {
        if activeLineIndex < dialogModel.dialogue.count  {
            dialogueLines.append(dialogModel.dialogue[activeLineIndex])
            activeLineIndex += 1
        }
    }
}

