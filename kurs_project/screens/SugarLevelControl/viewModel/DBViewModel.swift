//
//  DBViewModel.swift
//  kurs_project
//
//  Created by user on 13/12/2022.
//

import SwiftUI
import RealmSwift

class DBViewModel: ObservableObject {
    @Published var value = ""
    @Published var date : Date = Date()
    
    @Published var openNewPage = false
    
    @Published var cards: [Card]  = []
    
    init(){
        fetchData()
    }
    
    func deleteData(object: Card){
        guard let dbRef = try? Realm() else{return}
        
        try? dbRef.write{
            dbRef.delete(object)
            fetchData()
        }
    }
    
    func fetchData(){
        guard let dbRef = try? Realm() else{return}
        
        let results = dbRef.objects(Card.self).sorted(byKeyPath: "date", ascending: false)
        self.cards = results.compactMap({
            (card) -> Card? in
            return card
        })
    }
    
    func addData(presentation: Binding<PresentationMode>){
        let card = Card()
        card.value = value
        card.date = Date()
        
        guard let dbRef = try? Realm() else{return}
        try? dbRef.write{
            dbRef.add(card)
            
            fetchData()
        }
        presentation.wrappedValue.dismiss()
        cleanData()
    }
    
    
    func cleanData(){
        value = ""
    }
}
