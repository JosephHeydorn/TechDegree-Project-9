//
//  MapView.swift
//  Unit9 Project Folder
//
//  Created by Joseph Heydorn on 1/15/20.
//  Copyright © 2020 Joseph Heydorn. All rights reserved.
//

import SwiftUI
import MapKit

struct MyMap: UIViewRepresentable {
    
    let mapView = MKMapView(frame: UIScreen.main.bounds)
    
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MyMap>) {
        
    }
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }


}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MyMap()
    }
}

protocol AddNotificationDelegate {
    func addNotificationDelegate(didAddCoordinate coordinate: CLLocationCoordinate2D, radius: Double, reminderEntry: String, onEntry: Bool, identifier: String)
}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var mapViewControl: MKMapView
    var anotations: [addAnotationPin] = []
    
    var locationManager = CLLocationManager()
    
    
    init(_ control: MKMapView) {
        self.mapViewControl = control
    }
    
    // MARK: Adding New Pin
    
    func add(_ addAnotation: addAnotationPin) {
        anotations.append(addAnotation)
        mapViewControl.addAnnotation(addAnotation)
    }
 
    // MARK: Other MapView Items
    func region(with addAnotationPin: addAnotationPin) -> CLCircularRegion {
        let region = CLCircularRegion(center: addAnotationPin.coordinate, radius: addAnotationPin.radius, identifier: addAnotationPin.identifier)
        region.notifyOnEntry = true
        return region
    }
    
    func startMonitoring(anotations: addAnotationPin) {
        let fencedRegion = region(with: anotations)
        locationManager.startMonitoring(for: fencedRegion)
    }
}

extension MapViewCoordinator: AddNotificationDelegate {
    func addNotificationDelegate(didAddCoordinate coordinate: CLLocationCoordinate2D, radius: Double, reminderEntry: String, onEntry: Bool, identifier: String) {
        let geoLocation = addAnotationPin(title: reminderEntry, onEntry: onEntry, radius: radius, coordinate: coordinate, identifier: identifier)
        add(geoLocation)
        
    }
    
}

class addAnotationPin: NSObject, MKAnnotation {
    let title: String?
    let onEntry: Bool
    let radius: Double
    let coordinate: CLLocationCoordinate2D
    let identifier: String
    
    init(title: String?, onEntry: Bool, radius: Double, coordinate: CLLocationCoordinate2D, identifier: String) {
        self.title = title
        self.onEntry = onEntry
        self.radius = radius
        self.coordinate = coordinate
        self.identifier = identifier
    }
}

