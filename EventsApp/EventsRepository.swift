//
//  EventsRepository.swift
//  EventsApp
//
//  Created by Michał Grygolec on 30/11/2022.
//

import CoreLocation
import MapKit

class EventsRepository : NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var events: [Event] = []
    @Published var cooridnates: CLLocationCoordinate2D? = nil
    private let locMan = CLLocationManager()
    
    func loadData() async {
        if let url = URL(string: "https://knopers.com.pl/events.json"),
           let (data, _) = try? await URLSession.shared.data(from: url),
           let events = try? JSONDecoder().decode([Event].self, from: data) {
            await publish(events)
        }
    }
    
    @MainActor
    private func publish(_ events: [Event]){
        self.events = events
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let cords = manager.location?.coordinate {
            self.cooridnates = cords
        }
    }
    
    func askForLocation(){
        locMan.requestWhenInUseAuthorization()
    }
    
    func startMonitor() {
        if locMan.authorizationStatus == .authorizedWhenInUse {
            locMan.delegate = self
            locMan.startUpdatingLocation()
            locMan.startMonitoringSignificantLocationChanges()
        }
    }
    
    func stopMonitor() {
        if locMan.authorizationStatus == .authorizedWhenInUse {
            locMan.stopUpdatingLocation()
            locMan.stopMonitoringSignificantLocationChanges()
            locMan.delegate = nil
        }
    }
    
    
}
