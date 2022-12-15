//
//  NoteViewModel.swift
//  kurs_project
//
//  Created by user on 15/12/2022.
//
import SwiftUI
import RealmSwift

class NoteViewModel: ObservableObject {
    @Published var date : Date = Date()
    @Published var notes: [Note]  = []
    
    init(){
        fetchData()
    }
    
    func deleteData(object: Note){
        guard let dbRef = try? Realm() else{return}
        
        try? dbRef.write{
            dbRef.delete(object)
            fetchData()
        }
    }
    
    func fetchData(){
        guard let dbRef = try? Realm() else{return}
        
        let results = dbRef.objects(Note.self).sorted(byKeyPath: "date", ascending: false)
        self.notes = results.compactMap({
            (note) -> Note? in
            return note
        })
    }
    
    func addData(food_eaten: String, XE: Double){
        let note = Note()
        note.food_eaten = food_eaten
        note.date = Date()
        note.xe_record = XE
        
        guard let dbRef = try? Realm() else{return}
        try? dbRef.write{
            dbRef.add(note)
            
            fetchData()
        }
    }
    

}
