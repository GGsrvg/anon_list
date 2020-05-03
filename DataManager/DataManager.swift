//
//  DataManager.swift
//  DataManager
//
//  Created by GGsrvg on 03.05.2020.
//  Copyright © 2020 GGsrvg. All rights reserved.
//

import Foundation

public class DataManager {
    
    public static let shared  = DataManager()
    
    fileprivate init(){}
    
    // MARK: Netwrok
    public let api = Api.shared
}
