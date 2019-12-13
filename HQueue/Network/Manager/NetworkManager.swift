//
//  NetworkManager.swift
//  HQueue
//
//  Created by Yosia on 07/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import Foundation

struct NetworkManager {

    private let router = Router<HQAuthAPI>()
    private let routerHospital = Router<HospitalAPI>()
    private let routerPatient = Router<PatientAPI>()
    private let routerQueue = Router<Queue>()

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        
        switch response.statusCode {
        case 200...299:
            return .success
        case 400...499:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 500...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.faield.rawValue)
        }
    }

    func login(email: String, password: String, completion: @escaping(_ auth: HQAuth?, _ error: String?) -> ()){
        router.request(.signin(email: email, password: password), completion: { data, response, error in
            if error != nil {
                completion(nil, NetworkResponse.faield.rawValue)
            }

            if let response = response as? HTTPURLResponse {
                let result =  self .handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    //print(String(bytes: responseData, encoding: .utf8))
                    do {
                        //print( String(bytes: responseData, encoding: .utf8) )
                        let data = try JSONDecoder().decode(HQAuth.self, from: responseData)
                        //print(data)
                        completion(data, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        })
    }
    
    func sigupAndCretePatient(newAuth: HQAuth, newPass: String, patientData: Patient, completion: @escaping(_ auth: HQAuth?, _ error: String?) -> ()) {
        router.request(.signup(email: newAuth.email, name: newAuth.name, password: newPass, phoneNumber: newAuth.phoneNumber), completion: {data, response, error in
            if error != nil {
                completion(nil, NetworkResponse.faield.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result =  self .handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        //print( String(bytes: responseData, encoding: .utf8) )
                        let data = try JSONDecoder().decode(HQAuth.self, from: responseData)
                        completion(data, nil)
                    } catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        })
    }
    
    func getProfile(completion: @escaping(_ auth: HUser?, _ error: String?) -> ()) {
        router.request(.getProfile) { (data, response, error) in
            if error != nil {
                completion(nil, NetworkResponse.faield.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result =  self .handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        //print( String(bytes: responseData, encoding: .utf8) )
                        let data = try JSONDecoder().decode(HUser.self, from: responseData)
                        completion(data, nil)
                    } catch {
                        //print(#function, decoderError )
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func postProfile(profile: HUser, completion: @escaping(_ auth: HUser?, _ error: String?) -> ()) {
        router.request(.postProfile(user: profile)) { (data, response, error) in
            if error != nil {
               completion(nil, NetworkResponse.faield.rawValue)
           }
           
           if let response = response as? HTTPURLResponse {
               let result =  self .handleNetworkResponse(response)
               switch result {
               case .success:
                   guard let responseData = data else {
                       completion(nil, NetworkResponse.noData.rawValue)
                       return
                   }
                   do {
                       //print( String(bytes: responseData, encoding: .utf8) )
                       let data = try JSONDecoder().decode(HUser.self, from: responseData)
                       completion(data, nil)
                   } catch {
                       //print(#function, decoderError )
                       completion(nil, NetworkResponse.unableToDecode.rawValue)
                   }
               case .failure(let networkFailureError):
                   completion(nil, networkFailureError)
               }
           }
        }
    }
    
    func getHospital(search: String?, page: Int = 1, completion: @escaping(_ data: HospitalResponse?, _ error: String?) -> ()) {
        routerHospital.request(.getHospital(search: search, page: page)) { (data, response, error) in
            if error != nil {
                completion(nil, NetworkResponse.faield.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        //print(#function, String( bytes: responseData, encoding: .utf8)  )
                        let data = try JSONDecoder().decode(HospitalResponse.self, from: responseData)
                        //print(#function, data)
                        completion(data, nil)
                    }catch{
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailurError):
                    completion(nil, networkFailurError)
                }
            }
        }
    }
    
    func getPoli(hospitalId: String, search: String?, page: Int = 1, completion: @escaping(_ data: PoliResponse?, _ error: String?) -> ()) {
        routerHospital.request(.getPoli(hospitalId: hospitalId, search: search, page: page)) { (data, response, error) in
            if error != nil {
                completion(nil, NetworkResponse.faield.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        //print(#function, String( bytes: responseData, encoding: .utf8)  )
                        let data = try JSONDecoder().decode(PoliResponse.self, from: responseData)
                        //print(#function, data)
                        completion(data, nil)
                    }catch{
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailurError):
                    completion(nil, networkFailurError)
                }
            }
        }
    }
    
    func getDoctor(search: String? ,poli: Poli, page: Int = 1, completion: @escaping(_ data: [Doctor]?, _ error: String?) -> ()) {
        routerHospital.request(.getDoctor(search: search, poli: poli, page: page)) { (data, response, error) in
            if error != nil {
                completion(nil, NetworkResponse.faield.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        //print(#function, String( bytes: responseData, encoding: .utf8)  )
                        let data = try JSONDecoder().decode([Doctor].self, from: responseData)
                        //print(#function, data)
                        completion(data, nil)
                    }catch{ //let errorDecode{
                        //print(#function, errorDecode)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailurError):
                    completion(nil, networkFailurError)
                }
            }
        }
    }
    
    func getInsurance(hospital_id: String, completion: @escaping(_ data: [Asuransi]?, _ error: String?) -> ()) {
        routerHospital.request(.getInsurance(hospital_id: hospital_id)) { (data, response, error) in
            if error != nil {
                completion(nil, NetworkResponse.faield.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        //print(#function, String( bytes: responseData, encoding: .utf8)  )
                        let data = try JSONDecoder().decode([Asuransi].self, from: responseData)
                        //print(#function, data)
                        completion(data, nil)
                    }catch{//let errorDecode{
                        //print(#function, errorDecode)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailurError):
                    completion(nil, networkFailurError)
                }
            }
        }
    }
    
    func getPatient(completion: @escaping(_ data: [Patient]?, _ error: String?) -> ()) {
        routerPatient.request(.getPatient) { (data, response, error) in
            if error != nil {
                completion(nil, NetworkResponse.faield.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let data = try JSONDecoder().decode([Patient].self, from: responseData)
                        completion(data, nil)
                    }catch let errorDecode{
                    print(#function, errorDecode)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailurError):
                    completion(nil, networkFailurError)
                }
            }
        }
    }
    
    func registerQueue(patienId: String, doctorScheduleId: String, insuranceId: String?, completion: @escaping(_ data: QueueResponse?, _ error: String?) -> ()) {
        routerQueue.request(.registerQueue(patientId: patienId, doctorScheduleId: doctorScheduleId, insuranceId: insuranceId)) { data, response, error in
            if error != nil {
                completion(nil, NetworkResponse.faield.rawValue)
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        print(#function, String( bytes: responseData, encoding: .utf8)  )
                        let data = try JSONDecoder().decode(QueueResponse.self, from: responseData)
                        completion(data, nil)
                    }catch let errorDecode{
                        print(#function, errorDecode)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailurError):
                    print(networkFailurError)
                    completion(nil, networkFailurError)
                }
            }
        }
    }
    
    func getCurrentQueue(completion: @escaping(_ data: QueueEntity?, _ error: String?) -> ()) {
        routerQueue.request(.getCurrentQueue) { data, response, error in
            if error != nil {
                completion(nil, NetworkResponse.faield.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let data = try JSONDecoder().decode(QueueEntity.self, from: responseData)
                        completion(data, nil)
                    }catch let errorDecode{
                        print(#function, errorDecode)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    
                case .failure(let networkFailurError):
                    completion(nil, networkFailurError)
                }
            }
        }
    }
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated"
    case badRequest = "Not a good request"
    case outdated = "linknya dah expire"
    case faield = "Request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "Cannot decode"
}

enum Result<String> {
    case success
    case failure(String)
}
