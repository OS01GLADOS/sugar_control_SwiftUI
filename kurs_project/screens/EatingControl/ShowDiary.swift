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
    
    private static var notificationDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM, HH:mm"
        return dateFormatter
    }()
    private func timeDisplayText(date: Date) -> String {
        return Self.notificationDateFormatter.string(from: date)
    }
    
    
    
    var body: some View {
        List{
            HStack{
                Text("Дата")
                Spacer()
                Text("еда")
                Spacer()
                Text("ХЕ")
            }
            ForEach(modelData.notes){note in
                HStack{
                    Text(timeDisplayText(date:note.date))
                    Spacer()
                    Text(note.food_eaten)
                    Spacer()
                    Text("\(note.xe_record, specifier: "%.2f")")
                }
            }
            .onDelete(perform: delete)
                
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

extension EatingControlScreen{
    func delete(_ indexSet: IndexSet){
        var note = indexSet.map{modelData.notes[$0]}.first
        modelData.deleteData(object: note!)
    }
}
