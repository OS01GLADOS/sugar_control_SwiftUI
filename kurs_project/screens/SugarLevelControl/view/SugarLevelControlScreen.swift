//
//  SugarLevelControlScreen.swift
//  kurs_project
//
//  Created by user on 04/12/2022.
//

import SwiftUI

struct SugarLevelControlScreen: View {
    
    @StateObject var modelData = DBViewModel()
    
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
                ForEach(modelData.cards){card in
                    VStack(alignment: .leading, spacing: nil ){
                        Text("\(card.value) ммоль").foregroundColor((Double(card.value)! > 5.5 || Double(card.value)! < 3.9) ? Color.white : Color.black)
                        Text(timeDisplayText(date: card.date)).foregroundColor((Double(card.value)! > 5.5 || Double(card.value)! < 3.9) ? Color.white : Color.black)
                        
                    }
                    .listRowBackground((Double(card.value)! > 5.5 || Double(card.value)! < 3.9) ? Color.red : Color.white )
              }
                .onDelete(perform: delete)
        }
        .navigationTitle("Контроль сахара")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {modelData.openNewPage.toggle()}){
                    Text("Добавить запись")
                }
            }
            ToolbarItem(placement: .navigationBarLeading){
                NavigationLink(destination: SugarLevelNotifications()) {
                                    Text("Напоминания")
                                }
            }
        }
        .sheet(isPresented: $modelData.openNewPage, content: {
            AddNoteView()
                .environmentObject(modelData)
        })
    }
}

extension SugarLevelControlScreen {
    func delete(_ indexSet: IndexSet){
        var card = indexSet.map{modelData.cards[$0]}.first
        modelData.deleteData(object: card!)
    }
}
