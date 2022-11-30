//
//  EventsRepository.swift
//  EventsApp
//
//  Created by Michał Grygolec on 30/11/2022.
//

import Foundation

class EventsRepository : ObservableObject{
    @Published var events: [Event] = []
    
    func loadData() async {
        if let url = URL(string: "https://knopers.com.pl/events.json"),
           let (data, _) = try? await URLSession.shared.data(from: url),
           let events = try? JSONDecoder().decode([Event].self, from: data) {
            self.events = events
        }
    }
    
    @MainActor
    private func publish(_ events: [Event]){
        self.events = events
    }
    
}
