//
//  ContentView.swift
//  EventsApp
//
//  Created by Michał Grygolec on 30/11/2022.
//

import SwiftUI

struct ContentView: View {

    @StateObject var eventRepo = EventsRepository()
    
    var body: some View {
        List {
            ForEach(eventRepo.events) { event in
                Text(event.name)
            }
        }
        .task {
            await eventRepo.loadData()
        }
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
