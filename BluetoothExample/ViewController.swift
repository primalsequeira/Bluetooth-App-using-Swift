//
//  ViewController.swift
//  BluetoothExample
//
//  Created by Sequeira, Primal Carol on 19/01/22.
//

import UIKit
import CoreBluetooth


class ViewController: UIViewController, CBCentralManagerDelegate {

    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var devicesTable: UITableView!
 
    
    var conn: String?
    var myPeripheral: CBPeripheral?
    var devicesnum: Int = 0
    var devicesData: [DeviceData] = []
    var uniqueDevicesData: [DeviceData] = []
    var timer: Timer?
    // scanning peripherals and connecting
    var centralManager: CBCentralManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        scanButton.isEnabled = true
        scanButton.layer.cornerRadius = 20
        print(devicesData)
   
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.devicesTable.reloadData()
            if let cm = self.centralManager {
                self.centralManagerDidUpdateState(cm)
            }
        }
    }
  

    override func viewDidDisappear(_ animated: Bool) {
        devicesData = []

    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(ViewController.stopScanning), userInfo: nil, repeats: true)
            central.scanForPeripherals(withServices: nil, options: nil)
            print("Scanning .....")
            devicesData = []
            
            
        } else {
            print("\(central.state.rawValue)")
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
    }
    @objc func stopScanning()
    {
        timer?.invalidate()
        print("timer stopped")
        centralManager.stopScan()
        print("Scan Stopped")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        setTableView()
        print(peripheral)
        //print(advertisementData)
        var conn : String? {
            if peripheral.state.rawValue == 0 {
                return "Not Connected"
            } else {
                return "Connected"
            }
        }
        var data1 = DeviceData.init(name: "\(peripheral.name ?? "")", connectionStatus: "\(conn!)", peripheral: peripheral)
        if data1.name != "" {
            devicesData.append(data1)
        }
        uniqueDevicesData = unique(devices: devicesData)
    
        self.devicesTable.reloadData()

        
        
//        if peripheral.name?.contains("OP Headset") == true || peripheral.name?.contains("OnePlus") == true  {
//            myPeripheral = peripheral
//            central.connect(peripheral, options: nil)
//            print("Connected")
//            central.stopScan()
//            setTableView()
//
//            if let index = devicesData.index(where: { $0.name == "OnePlus Bullets Wireless Z" }) {
//                devicesData[index].connectionStatus = "Connected"
//            }
//        }
        
    }
    
    func unique(devices: [DeviceData]) -> [DeviceData] {

        var uniqueDevices = [DeviceData]()

        for device in devicesData {
            if !uniqueDevices.contains(device) {
                uniqueDevices.append(device)
            }
        }

        return uniqueDevices
    }

    @IBAction func scanClicked(_ sender: Any) {
        centralManager = CBCentralManager.init(delegate: self, queue: nil)
        DispatchQueue.main.async {
            //self.devicesTable.reloadData()
            if let cm = self.centralManager {
                self.centralManagerDidUpdateState(cm)
            }

        }

  
    }
    
   
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func setTableView() {
        devicesTable.delegate = self
        devicesTable.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uniqueDevicesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DevicesViewCellID", for: indexPath) as UITableViewCell
        if let cellIs = cell as? DevicesViewCell {
            let device = uniqueDevicesData[indexPath.row]
            cellIs.setData(name: device.name, conntype: device.connectionStatus)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if devicesData[indexPath.row].connectionStatus == "Not Connected" {
            centralManager.connect(uniqueDevicesData[indexPath.row].peripheral, options: nil)
            uniqueDevicesData[indexPath.row].connectionStatus = "Connected"
            myPeripheral = uniqueDevicesData[indexPath.row].peripheral
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
            //
            controller.centralManager = self.centralManager
            controller.myperipheral = self.myPeripheral
            controller.devicesData = self.uniqueDevicesData
            controller.navtitle = uniqueDevicesData[indexPath.row].name
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }



}

