//
//  DevicePresenter.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 29.03.2022.
//

import Foundation
import MapKit
import CoreLocation

class DetailsPresenter {
  let device: Device
  
  init(device: Device) {
    self.device = device
  }
  
  func updateLocationOnMap(mapView: MKMapView) {
    let point = MKPointAnnotation()
    
    guard let latitude = CLLocationDegrees(self.device.longitude), let longitude = CLLocationDegrees(self.device.latitude) else { return }

    let location = CLLocation(latitude: latitude, longitude: longitude)
    
    point.coordinate = location.coordinate
    point.title = self.device.placeUa
    
    mapView.removeAnnotations(mapView.annotations)
    mapView.addAnnotation(point)

    let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
    mapView.setRegion(viewRegion, animated: true)
    
    print(point.coordinate)
  }
}
