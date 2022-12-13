//
//  AddNoteView.swift
//  kurs_project
//
//  Created by user on 13/12/2022.
//

import SwiftUI
import Combine

struct AddNoteView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var modelData: DBViewModel
    var body: some View {
        NavigationView{
            List{
                Text("Новая Запись")
                Section(header: Text("Значение (в ммоль)")){
                    TextField("", text: $modelData.value)
                        .onReceive(Just(modelData.value)) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            if filtered != newValue {
                                modelData.value = filtered
                            }
                        }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action:{modelData.addData(presentation: presentation)}, label: {Text("Сохранить")})
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action:{
                        modelData.cleanData()
                        presentation.wrappedValue.dismiss()
                        
                    }, label: {Text("Отмена")})
                }
            }
        }
       
    }
}
