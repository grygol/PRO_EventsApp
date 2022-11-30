//
//  EventsMapView.swift
//  EventsApp
//
//  Created by Michał Grygolec on 30/11/2022.
//

import SwiftUI
import MapKit

struct EventsMapView: View {
    
    @StateObject var eventsRepo: EventsRepository
    @State var isPresented = false
    
    @State var observedRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 52.223807, longitude: 20.994122), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        
        let sheet = SheetPresentation(isPresented: $isPresented) {
            Text("CLICK ME")
        }
        
        Map(coordinateRegion: $observedRegion, annotationItems: eventsRepo.events) { event in
            MapAnnotation(coordinate: event.geo.location) {
//                Button {
//                    print(event.name)
//                    isPresented = true
//                } label: {
//                    Image(systemName: "mappin.circle.fill")
//                }.sheetPresentation(isPresented: $isPresented) {
//                    VStack {
//                        Text(event.name)
//                        Button("Get Cords") {
//                            print(eventsRepo.cooridnates)
//                        }
//                    }
//                }
                Circle().fill(.blue).frame(width: 20, height: 20, alignment: .center)
//
            }
        }
        .modifier(sheet)
        .onAppear {
            eventsRepo.startMonitor()
        }
        .onDisappear {
            eventsRepo.stopMonitor()
        }
    }
}

extension View {
    func sheetPresentation<Content>(isPresented: Binding<Bool>, content: () -> Content) -> some View where Content: View {
        modifier(
            SheetPresentation(isPresented: isPresented, content: content)
        )
    }
}

struct EventsMapView_Previews: PreviewProvider {
    static var previews: some View {
        EventsMapView(eventsRepo: EventsRepository())
    }
}
