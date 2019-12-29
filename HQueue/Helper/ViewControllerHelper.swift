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
    
    func hideKeyboarWhenTapView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(gesture:)))
        view?.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(gesture: UITapGestureRecognizer) {
        view?.endEditing(true)
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
    
    // MARK: - Open Phone Call
    func openPhoneCall(phoneNumber: String) {
        let number = phoneNumber.replacingOccurrences(of: "[^\\d+]", with: "", options: .regularExpression, range: nil)
        guard let url = URL(string: "tel://\(number)") else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: Manage state in user default
    func isLogged() -> Bool {
        return UserDefaults.standard.bool(forKey: UserEnv.isLogged.rawValue)
    }
    
    func isInQueue() -> Bool {
        return UserDefaults.standard.bool(forKey: UserEnv.isInQueue.rawValue)
    }
    
    func setIsInQueue(_ val: Bool) {
        UserDefaults.standard.set(val, forKey: UserEnv.isInQueue.rawValue)
    }
    
    func setIsLogged(name: String, email: String, token: String) {
        UserDefaults.standard.set(name, forKey: UserEnv.authName.rawValue)
        UserDefaults.standard.set(email, forKey: UserEnv.authEmail.rawValue)
        UserDefaults.standard.set(token, forKey: UserEnv.authToken.rawValue)
        UserDefaults.standard.set(true, forKey: UserEnv.isLogged.rawValue)
    }
    
    func setIsLogout() {
           UserDefaults.standard.removeObject(forKey: UserEnv.authName.rawValue)
           UserDefaults.standard.removeObject(forKey: UserEnv.authEmail.rawValue)
           UserDefaults.standard.removeObject(forKey: UserEnv.authToken.rawValue)
           UserDefaults.standard.set(false, forKey: UserEnv.isLogged.rawValue)
       }
}

enum UserEnv: String {
    case isLogged = "com.antridoc.is_logged"
    case authName = "com.antridoc.auth.name"
    case authEmail = "com.antridoc.auth.email"
    case authToken = "com.antridoc.auth.token"
    case isInQueue = "com.antridoc.is_in_queue"
    case didOnBoarding = "com.antridoc.did_OnBoarding"
    case deviceToken = "com.antridoc.device_token"
    case didRegistered = "com.antridoc.did_registerd"
}
