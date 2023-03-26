//
//  AppId.swift
//  FocusTimer
//
//  Created by Robert P on 26.03.2023.
//

import Foundation

func valueForAppId() -> String {
    let filePath = Bundle.main.path(forResource: "AppId", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: "AppId") as! String
    
    return value
}
