//
//  DeviceData.swift
//  BluetoothExample
//
//  Created by Sequeira, Primal Carol on 25/01/22.
//

import Foundation
import CoreBluetooth


struct DeviceData: Equatable {
    var name: String
    var connectionStatus : String
    var peripheral : CBPeripheral
}
