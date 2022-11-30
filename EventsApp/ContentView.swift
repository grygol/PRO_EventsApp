//
//  ContentView.swift
//  EventsApp
//
//  Created by Michał Grygolec on 30/11/2022.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject var eventRepo = EventsRepository()
    @State var position = 0
    
    
    var body: some View {
        NavigationView {
            TabView(selection: $position) {
                List {
                    ForEach(eventRepo.events) { event in
                        Text(event.name)
                    }
                }
                .tabItem {
                   Text("Lista")
                }.tag(0)
                
                
                EventsMapView(eventsRepo: eventRepo)
                    .tabItem {
                        Text("Mapa")
                    }.tag(1)
            }
        }
        .onAppear {
            eventRepo.askForLocation()
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
