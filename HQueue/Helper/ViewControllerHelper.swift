//
//  File.swift
//  HQueue
//
//  Created by Faridho Luedfi on 15/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit
import MapKit

extension UIViewController {
    
    func setTransparantNav() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func presentAlert(alert: UIAlertController, actions: [UIAlertAction]?, comletion: (() -> ())?) {
        
        // Add actions
        if let actions: [UIAlertAction] = actions {
            for action in actions {
                alert.addAction(action)
            }
        } else {
            alert.addAction(.init(title: "Tutup", style: .cancel, handler: nil))
        }
        
        present(alert, animated: true, completion: comletion)
    }
    
    // MARK: - Handle Map Action
    // TODO: menampilkan di google maps ?
    func setupForOpenMap(placeName: String, long: CLLocationDegrees, lat: CLLocationDegrees) {
        let coordinate = CLLocationCoordinate2DMake(lat, long)
        print(#function, coordinate)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        let options = [
            MKLaunchOptionsMapCenterKey : NSValue(mkCoordinate: region.center),
            MKLaunchOptionsMapSpanKey : NSValue(mkCoordinateSpan: region.span)
        ]
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        mapItem.openInMaps(launchOptions: options)
    }
}
