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
                Spacer()
                List{
                    ForEach(notasViewModel.notes, id: \.id) { nota in
                        HStack{
                            Text(nota.description)
                        }
                    }
                }
            }
            .navigationTitle("Notas")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
