//
//  VpnChecker.swift
//  PitCrew Kart Tracker
//
//  Created by Николай Щербаков on 22.07.2024.
//

import Foundation

struct VpnChecker {

    private static let vpnProtocolsKeysIdentifiers = [
        "tap", "tun", "ppp", "ipsec", "utun"
    ]

    static func isVpnActive() -> Bool {
        guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
            let allKeys = keys.allKeys as? [String] else { return false }

        // Checking for tunneling protocols in the keys
        for key in allKeys {
            for protocolId in vpnProtocolsKeysIdentifiers
                where key.starts(with: protocolId) {
                return true
            }
        }
        return false
    }
}
