//
//  MenuController.swift
//  Restaurant
//
//  Created by Mikhail Ladutska on 1/31/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import UIKit

class MenuController {
    
    static let shared = MenuController()
    static let menuDataUpdateNotification = Notification.Name("MenuController.menuDataUpdated")
    //MARK: variables
    
    private var itemsByID = [Int: MenuItem]()
    private var itemsByCategory = [String: [MenuItem]]()
    
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdateNotification, object: nil)
        }
    }
    
    let baseUrl = URL(string: "http://localhost:8090/")!
    
    static let orderUpdateNotification = Notification.Name("MenuController.orderUpdated")
    
    //MARK: methods
    
    final func item(withID itemID: Int) -> MenuItem? {
        return itemsByID[itemID]
    }
    
    final func items(forCategory category: String) -> [MenuItem]? {
        return itemsByCategory[category]
    }
    
    var categories: [String] {
        get {
            return itemsByCategory.keys.sorted()
        }
    }
    
    final func loadOrder() {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let orderFileURL = documentsDirectoryURL.appendingPathComponent("order").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: orderFileURL) else {return}
        order = (try? JSONDecoder().decode(Order.self, from: data)) ?? Order(menuItems: [])
    }
    
    final func saveOrder() {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let orderFileURL = documentsDirectoryURL.appendingPathComponent("order").appendingPathExtension("json")
        if let data = try? JSONEncoder().encode(order) {
            try? data.write(to: orderFileURL)
        }
    }
    
    final func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    private func process(_ items: [MenuItem]) {
        itemsByID.removeAll()
        itemsByCategory.removeAll()
        
        for item in items {
            itemsByID[item.id] = item
            itemsByCategory[item.category, default: []].append(item)
        }
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: MenuController.menuDataUpdateNotification, object: nil)
        }
    }
    
    final func loadRemoteData() {
        let initialMenuURL = baseUrl.appendingPathComponent("menu")
        let components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        let menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL) { (data, _, _) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data) {
                self.process(menuItems.items)
            }
        }
        task.resume()
    }
    
    final func loadItems() {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let menuItemsFileURL = documentsDirectoryURL.appendingPathComponent("menuItems").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: menuItemsFileURL) else {return}
        let items = (try? JSONDecoder().decode([MenuItem].self, from: data)) ?? []
        process(items)
    }
    
    final func saveItems() {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let menuItemsFileURL = documentsDirectoryURL.appendingPathComponent("menuItems").appendingPathExtension("json")
        
        let items = Array(itemsByID.values)
        if let data = try? JSONEncoder().encode(items) {
            try? data.write(to: menuItemsFileURL)
        }
    }
    
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderUrl = baseUrl.appendingPathComponent("order")
        
        var request = URLRequest(url: orderUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data: [String: [Int]] = ["menuIds": menuIds]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data) {
                completion(preparationTime.prepTime)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    
}
