//
//  ShowDiary.swift
//  kurs_project
//
//  Created by user on 15/12/2022.
//

import SwiftUI

struct EatingControlScreen: View {
    
    @StateObject var modelData = NoteViewModel()
    @State private var isCreatePresented = false
    
    var body: some View {
        List{
            ForEach(modelData.notes){note in
                Text(note.food_eaten)
            }
                
        }
        .navigationTitle("Дневник питания")
        .navigationBarItems(trailing: Button {
            isCreatePresented = true
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
        })
        .sheet(isPresented: $isCreatePresented) {
            NavigationView {
                AddDataToDiary(
                    isPresented: $isCreatePresented
                ).environmentObject(modelData)
            }
            .accentColor(.primary)
        }
    }
}

