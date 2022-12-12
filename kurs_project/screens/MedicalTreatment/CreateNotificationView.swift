//
//  CreateNotificationView.swift
//  kurs_project
//
//  Created by user on 12/12/2022.
//

import SwiftUI
import Combine


struct CreateNotificationView: View {
    @ObservedObject var notificationManager: NotificationManager
    @State private var lastName = ""
    @State private var speciality = ""
    @State private var room = ""
    @State private var date = Date()
    @Binding var isPresented: Bool
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    VStack {
                        TextField("Фамилия врача", text: $lastName)
                        TextField("Специальность", text: $speciality)
                        TextField("Кабинет", text: $room)
                            .onReceive(Just(room)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.room = filtered
                                }
                            }
                        DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .cornerRadius(5)
                    
                    Button {
                        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .day, .month, .year], from: date)
                        let title = "\(lastName), \(room) каб."
                        let body = "\(speciality)"
                        notificationManager.createLocalNotification(title: title, dateComponents:dateComponents,  body:body) { error in
                            if error == nil {
                                DispatchQueue.main.async {
                                    self.isPresented = false
                                }
                            }
                        }
                    } label: {
                        Text("Создать")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(5)
                    .buttonStyle(PlainButtonStyle())
                }
                .listRowBackground(Color(.systemGroupedBackground))
            }
        }
        .listStyle(InsetGroupedListStyle())
        .onDisappear {
            notificationManager.reloadLocalNotifications()
        }
        .navigationTitle("Новое обследование")
        .navigationBarItems(trailing: Button {
            isPresented = false
        } label: {
            Image(systemName: "xmark")
                .imageScale(.large)
        })
    }
}


