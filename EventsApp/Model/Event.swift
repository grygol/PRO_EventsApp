//
//  Event.swift
//  EventsApp
//
//  Created by Michał Grygolec on 30/11/2022.
//

import Foundation
import MapKit

struct Event: Codable, Identifiable {

    let id: Int

    let name, dateBegin, dateEnd, eventType: String

    let location: String

    let geo: Geo

    

    var imageUrl: URL? { URL(string: "https://konwenty-poludniowe.pl/images/joodb/db1/img\(id).jpg") }


 

    enum CodingKeys: String, CodingKey {

        case id, name

        case dateBegin = "date_begin"

        case dateEnd = "date_end"

        case eventType = "event_type"

        case location, geo

    }

}


 

// MARK: - Geo

struct Geo: Codable {

    let lat, lng: String
    
    var location : CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: try! Double(lat, format: .number), longitude: try! Double(lat, format: .number)) }

}
