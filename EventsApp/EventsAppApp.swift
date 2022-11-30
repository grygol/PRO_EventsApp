//
//  EventsAppApp.swift
//  EventsApp
//
//  Created by Michał Grygolec on 30/11/2022.
//

import SwiftUI

@main
struct EventsAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
