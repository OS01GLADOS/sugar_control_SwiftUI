//
//  Screen1.swift
//  kurs_project
//
//  Created by user on 04/12/2022.
//

import Foundation

import SwiftUI

struct MainScreen : View {
    
    var body: some View {
        NavigationView {
            List {
                    NavigationLink(destination: SugarLevelControlScreen()) {
                        Text("Мониторинг Глюкозы")
                    }
                    NavigationLink(destination: EatingControlScreen()) {
                        Text("Контроль питания")
                    }
                    NavigationLink(destination: CalculateDrugDozeScreen()) {
                        Text("Расчет дозы инсулина")
                    }
                    NavigationLink(destination: MedicalTreatmentScreen()) {
                        Text("График обследований")
                    }
                }
            .navigationTitle("Sugar Control")
        }
    }
}
