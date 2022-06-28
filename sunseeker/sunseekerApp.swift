//
//  sunseekerApp.swift
//  sunseeker
//
//  Created by gary.odonoghue  on 25/06/2022.
//

import SwiftUI
import UIKit
import GooglePlaces

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "GSM_API_KEY") as? String
        guard let key = apiKey, !key.isEmpty else {
            print("Failed to set GSM API key!")
            return false
        }
        GMSPlacesClient.provideAPIKey(key)
        return true
    }
}

@main
struct sunseekerApp: App {
    
    // inject into SwiftUI life-cycle via adaptor !!!
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
