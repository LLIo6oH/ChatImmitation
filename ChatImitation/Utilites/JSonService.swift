//
//  JSonService.swift
//  ChatImitation
//
//  Created by Dmitry Kuklin on 08.09.2020.
//

import Foundation

class JSonService {
//    static let shared = JSonService()
    
    func readDialogJson(completionHandler: @escaping (DialogueModel) -> Void, failure: @escaping (Error?) -> Void){
        let url = Bundle.main.url(forResource: "dialogue", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        guard let lines = try? decoder.decode(DialogueModel.self, from: data) else {
            let error = NSError(domain: "JSonError", code: 100, userInfo: ["errorDescription": "Can't parse JSon"])
            failure(error)
            return
        }
        completionHandler(lines)
    }
}
