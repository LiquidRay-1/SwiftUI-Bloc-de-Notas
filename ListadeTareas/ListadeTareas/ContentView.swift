//
//  ContentView.swift
//  ListadeTareas
//
//  Created by dam2 on 11/3/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var descriptionNote: String = "Crear una nota"
    @StateObject var notasViewModel = NotasViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Añade una nota")
                    .underline()
                    .foregroundStyle(.blue)
                TextEditor(text: $descriptionNote)
                    .frame(height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.blue, lineWidth: 2)
                        
                    )
                    .padding(.horizontal)
                Button("Crear nota"){
                    notasViewModel.saveNote(description: descriptionNote) //Guardar la nota
                    descriptionNote = ""
                }
                .buttonStyle(.bordered)
                .tint(.blue)
                .disabled(descriptionNote.isEmpty)
                Spacer()
                List{
                    ForEach($notasViewModel.notes, id: \.id) { $nota in
                        HStack{
                            if nota.isFavorite {
                                Label(nota.description, systemImage: "star.fill")
                            }else{
                                Text(nota.description)
                            }
                        }
                        .swipeActions(edge: .leading){
                            Button(){
                                notasViewModel.updateFavoriteNote(note: $nota)
                            } label: {
                                Label("Favorito", systemImage: "star.fill")
                            }
                            .tint(.blue)
                        }
                        .swipeActions(edge: .trailing){
                            Button(){
                                notasViewModel.removeNote(withID: nota.id)
                            } label: {
                                Label("Eliminar", systemImage: "trash.fill")
                            }
                            .tint(.red)
                        }
                    }
                }
            }
            .navigationTitle("Notas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Text(notasViewModel.numberNotes())
            }
        }
    }
}

#Preview {
    ContentView()
}
