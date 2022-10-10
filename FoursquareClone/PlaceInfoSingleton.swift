//
//  PlaceInfoSingleton.swift
//  FoursquareClone
//
//  Created by Alihan AÇIKGÖZ on 10.10.2022.
//

import Foundation
import UIKit

// Aşağıda oluşturulan "PlaceInfo" sınıfı bir Singleton Class. Burada sadece belirtilen değişkenlerle bir obje örneklendirilebileceği(instance yapılabileceği) belirtilmekte olup bu classı diğer tüm ViewController içerisindeki istediğimiz class ya da fonksiyon içerisinden çağırabiliyoruz. Bir diğer deyişle korunaklı bir GlobalVariable oluyor.
class PlaceInfo {
    static let sharedInstance = PlaceInfo()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage:UIImage?
    
    private init() {}
}

