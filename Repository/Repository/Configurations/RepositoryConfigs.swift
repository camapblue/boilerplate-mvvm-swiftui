//
//  RepositoryConfigs.swift
//  Repository
//
//  Created by Hao Tran Thien on 06/01/2022.
//

import Foundation

enum ConfigKey: String {
    case apiEndpointUrl = "apiEndpointUrl"
}

class RepositoryConfigs {
    static let shared = RepositoryConfigs()
    
    var apiEndpointUrl: String {
        return Bundle.main.readStringFromConfig(key: .apiEndpointUrl)
    }
}

// MARK: - Extension on bundle to read config variable
extension Bundle {

    /// Read one variable from the bundle plist file
    ///
    /// - Parameter key: the config to read
    /// - Returns: the value from config file
    func readStringFromConfig(key: ConfigKey) -> String {
        return Bundle.main.object(forInfoDictionaryKey: key.rawValue) as! String
    }
}
