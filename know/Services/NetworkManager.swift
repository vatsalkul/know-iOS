//
//  NetworkManager.swift
//  know
//
//  Created by Vatsal Kulshreshtha on 26/03/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "http://know-corona.herokuapp.com/"
    let cache = NSCache<NSString, UIImage>()
    
    func getNotifications(completed: @escaping (Result<[Notification], KNError>) -> Void) {
        let endPoint = baseUrl + "notifications"
        
        guard let url = URL(string: endPoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.serverError))
            }
       
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.serverError))
                return
                
            }
            
            guard let data = data else {
                completed(.failure(.serverError))
                return
            }
            do {
                let decoder = JSONDecoder()
                
                let notifications = try decoder.decode([Notification].self, from: data)
                completed(.success(notifications))
            } catch{
                completed(.failure(.serverError))
            }
            
        }
        task.resume()
    }
    
    func getDashboard(completed: @escaping (Result<Dashboard, KNError>) -> Void) {
        let endPoint = baseUrl + "home"
        
        guard let url = URL(string: endPoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.serverError))
            }
       
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.serverError))
                return
                
            }
            
            guard let data = data else {
                completed(.failure(.serverError))
                return
            }
            do {
                let decoder = JSONDecoder()
                let home = try decoder.decode(Dashboard.self, from: data)
                completed(.success(home))
                print(home)
            } catch{
                completed(.failure(.serverError))
            }
            
        }
        task.resume()
    }
    
    
    func getWorld(completed: @escaping (Result<[World], KNError>) -> Void) {
        let endPoint = baseUrl + "world"
        
        guard let url = URL(string: endPoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.serverError))
            }
       
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.serverError))
                return
                
            }
            
            guard let data = data else {
                completed(.failure(.serverError))
                return
            }
            do {
                let decoder = JSONDecoder()
                
                let worldStats = try decoder.decode([World].self, from: data)
                completed(.success(worldStats))
            } catch{
                completed(.failure(.serverError))
            }
            
        }
        task.resume()
    }
    
    
    func getIndianStates(completed: @escaping (Result<[India], KNError>) -> Void) {
        let endPoint = baseUrl + "india"
        
        guard let url = URL(string: endPoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.serverError))
            }
       
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.serverError))
                return
                
            }
            
            guard let data = data else {
                completed(.failure(.serverError))
                return
            }
            do {
                let decoder = JSONDecoder()
                
                let indiaStats = try decoder.decode([India].self, from: data)
                completed(.success(indiaStats))
            } catch{
                completed(.failure(.serverError))
            }
            
        }
        task.resume()
    }
    
}
