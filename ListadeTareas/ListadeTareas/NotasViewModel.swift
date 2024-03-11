//
//  File.swift
//  ListadeTareas
//
//  Created by dam2 on 11/3/24.
//

import Foundation
import SwiftUI

final class NotasViewModel: ObservableObject {
    
    @Published var notes: [NotasModel] = []
    
    private let userDefaults: UserDefaults = .standard
    
    init(){
        notes = getAllNotes()
    }
    
    func saveNote(description: String){
        //Crearla instancia de la nota con la descrpción
        let newNota = NotasModel(description: description)
        
        //Insertar la nota en el array de notas
        notes.insert(newNota, at: 0)
        
        //Actualizamos el array en UserDefaults
        self.encodeAndSaveNotes()
    }
    
    func getAllNotes() -> [NotasModel] {
        if let notasData = userDefaults.object(forKey: "notes") as? Data {
            if let notes = try? JSONDecoder().decode([NotasModel].self, from: notasData){
                return notes
            }
        }
        return []
    }
    
    //Codificar las notas en JSON y las almacena en UserDefaults
    private func encodeAndSaveNotes(){
        if let encoded = try? JSONEncoder().encode(notes){
            userDefaults.set(encoded, forKey: "notes")
        }
    }
    
    func removeNote(withID id: String){
        notes.removeAll(where: {$0.id == id})
        encodeAndSaveNotes()
    }
    
    func updateFavoriteNote(note: Binding<NotasModel>){
        note.wrappedValue.isFavorite = !note.wrappedValue.isFavorite
        encodeAndSaveNotes()
    }
}
