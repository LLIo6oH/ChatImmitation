//
//  DialogueModel.swift
//  ChatImitation
//
//  Created by Dmitry Kuklin on 08.09.2020.
//

import Foundation

struct DialogueModel: Identifiable, Decodable {
    let id = UUID()
    var dialogue : [DialogueLineModel]
}

struct DialogueLineModel: Identifiable, Decodable, Hashable {
    let id = UUID()
    let line: String
}
