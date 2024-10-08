//
//  AppDelegate.swift
//  FoursquareClone
//
//  Created by Alihan AÇIKGÖZ on 4.10.2022.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // Parse veri tabanı bağlantısını tamamlamak için Back4App isimli cloud database sağlayıcısı üzerinden bağlantı işlemlerini gerçekleştiriyoruz. bunu ise aşağıdaki "ParseClientConfiguration isimli fonksiyonun yardımı ile yapıyoruz. Bizden bir "block" bilgisi istiyor. Bu bilgileri de Back4App üzerinden oluşturduğumuz app bilgigilerindeki "App Settings>Server Settings>Core Settings üzerindeki settings linkinden ulaşıyoruz.
        // Bağlantıyı kurabilmemiz için gerekli parametreler ise;
            // ".applicationId"
            // ".clientKey"
            // ".server"
        // Tüm bunlar "String" veri türünde girilmektedir. Örnekleri aşağıdaki gibidir.
        let configuration = ParseClientConfiguration { (ParseMutableClientConfiguration) in
            ParseMutableClientConfiguration.applicationId = "Mko47GwKHjX5H3DidmykNm6P2K7ZCIOcb8nKDP6z"
            ParseMutableClientConfiguration.clientKey = "vB5EgQmSPxSjU8ufthDaLgTUSwwMO0mn3XBcSeis"
            ParseMutableClientConfiguration.server = "https://parseapi.back4app.com/"
        }
        Parse.initialize(with: configuration)
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

