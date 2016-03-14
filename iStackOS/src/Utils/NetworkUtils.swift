//
//  NetworkUtils.swift
//  iStackOS
//
//  Created by Marsal on 14/03/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import Foundation
import SystemConfiguration

func isConnectedToNetwork() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
        
        SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
    }
    
    var flags = SCNetworkReachabilityFlags.ConnectionAutomatic
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    
    return (isReachable && !needsConnection)
}