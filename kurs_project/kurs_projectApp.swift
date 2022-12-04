//
//  kurs_projectApp.swift
//  kurs_project
//
//  Created by user on 15/11/2022.
//

import SwiftUI

@main
struct kurs_projectApp: App {
    let persistenceController = PersistenceController.shared
    //add  views here
    var body: some Scene {
        WindowGroup {
            //ContentView()
             //  .environment(\.managedObjectContext, persistenceController.container.viewContext)
            MainScreen().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
