//
//  DentistWonderApp.swift
//  DentistWonder
//
//  Created by Mac on 29.06.2022.
//

import SwiftUI

@main
struct DentistWonderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
