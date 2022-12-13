//
//  SugarLevelNotifications.swift
//  kurs_project
//
//  Created by user on 13/12/2022.
//

import SwiftUI

struct SugarLevelNotifications: View {
    
    private var suffix = "крови"
    @StateObject private var notificationManager = NotificationManager()
    @State private var isCreatePresented = false
    
    private static var notificationDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
    private func timeDisplayText(from notification: UNNotificationRequest) -> String {
        guard let nextTriggerDate = (notification.trigger as? UNCalendarNotificationTrigger)?.nextTriggerDate() else { return "" }
        return Self.notificationDateFormatter.string(from: nextTriggerDate)
    }
    
    @ViewBuilder
    var infoOverlayView: some View {
        switch notificationManager.authorizationStatus {
        case .authorized:
            if notificationManager.getSpecificNotifications(suffix: suffix).isEmpty {
                InfoOverlayView(
                    infoMessage: "Напоминаний не назначено",
                    buttonTitle: "Создать новое",
                    systemImageName: "plus.circle",
                    action: {
                        isCreatePresented = true
                    }
                )
            }
        case .denied:
            InfoOverlayView(
                infoMessage: "Пожалуйста, включите уведомления для использования данной фунуции",
                buttonTitle: "Перейти к настройкам",
                systemImageName: "gear",
                action: {
                    if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            )
        default:
            EmptyView()
        }
    }
    
    
    
    var body: some View {
        List{
            ForEach(notificationManager.getSpecificNotifications(suffix: suffix), id: \.identifier) { notification in
                VStack(alignment: .leading){
                    Text(timeDisplayText(from: notification))
                        .fontWeight(.bold)
                    
                }
                
                    
            }
            .onDelete(perform: delete)
            switch notificationManager.authorizationStatus {
            case .authorized:
                if !notificationManager.getSpecificNotifications(suffix: suffix).isEmpty {
                    HStack{
                        Image(systemName: "info.circle").foregroundColor(.blue)
                        Text("Смахните влево для удаления").foregroundColor(.blue)
                    }
                }
                default:
                    EmptyView()
            }
        }
        .overlay(infoOverlayView)
        .navigationTitle("Напоминания")
        .onAppear(perform: notificationManager.reloadAuthorizationStatus)
        .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
            switch authorizationStatus {
            case .notDetermined:
                notificationManager.requestAuthorization()
            case .authorized:
                notificationManager.reloadLocalNotifications()
            default:
                break
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            notificationManager.reloadAuthorizationStatus()
        }
        .navigationBarItems(trailing: Button {
            isCreatePresented = true
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
        })
        .sheet(isPresented: $isCreatePresented) {
            NavigationView {
                CreateEverydayNotificationView(
                    notificationManager: notificationManager,
                    isPresented: $isCreatePresented
                )
            }
            .accentColor(.primary)
        }
    }
}

extension SugarLevelNotifications {
    func delete(_ indexSet: IndexSet) {
        notificationManager.deleteLocalNotifications(
            identifiers: indexSet.map { notificationManager.notifications[$0].identifier }
        )
        notificationManager.reloadLocalNotifications()
    }
}
