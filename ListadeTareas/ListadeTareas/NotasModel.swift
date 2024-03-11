//
//  NotasModel.swift
//  ListadeTareas
//
//  Created by dam2 on 11/3/24.
//

import Foundation

struct NotasModel: Codable {
    let id: String //ID Único para cada nota
    let description: String
    var isFavorite: Bool
    
    init(id: String = UUID().uuidString, description: String, isFavorite: Bool = false){
        self.id = id
        self.description = description
        self.isFavorite = isFavorite
    }
}
