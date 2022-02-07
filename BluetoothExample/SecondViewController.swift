//
//  SecondViewController.swift
//  BluetoothExample
//
//  Created by Sequeira, Primal Carol on 25/01/22.
//

import UIKit
import CoreBluetooth

class SecondViewController: UIViewController, CBCentralManagerDelegate{
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
        }
            
    }
    
    var devicesData = [DeviceData]()
    
    var centralManager: CBCentralManager?
    var myperipheral: CBPeripheral?
    var navtitle : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "\(navtitle ?? " ")"
        print(devicesData.count)
    }
    
    
    @IBAction func deviceTypeClicked(_ sender: Any) {
        print("\(centralManager)")
        print("\(myperipheral)")
        
        print("Device type")
    }
    
    @IBAction func forgetDeviceClicked(_ sender: Any) {
        centralManager(centralManager!, didDisconnectPeripheral: myperipheral!, error: nil)
        
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        central.cancelPeripheralConnection(peripheral)
        print("Disconnected")
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            controller.uniqueDevicesData = self.devicesData
            //controller.centralManager = self.centralManager
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    

}
