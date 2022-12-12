//
//  InfoOverlayView.swift
//  kurs_project
//
//  Created by user on 12/12/2022.
//

import SwiftUI

struct InfoOverlayView: View {
    let infoMessage: String
    let buttonTitle: String
    let systemImageName: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text(infoMessage)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            Button {
                action()
            } label: {
                Label(buttonTitle, systemImage: systemImageName)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(5)
        }
        .padding()
    }
}
