//
//  ExampleViewController.swift
//  Eddystone
//
//  Created by Tanner Nelson on 07/24/2015.
//  Copyright (c) 2015 Tanner Nelson. All rights reserved.
//

import UIKit
import Eddystone

class ExampleViewController: UIViewController {

    //MARK: Interface
    @IBOutlet weak var mainTableView: UITableView!
    
    //MARK: Properties
    var urls = Eddystone.Scanner.nearbyUrls
    var previousUrls: [Eddystone.Url] = []
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Eddystone.logging = true
        Eddystone.Scanner.start(self)
        
        self.mainTableView.rowHeight = UITableViewAutomaticDimension
        self.mainTableView.estimatedRowHeight = 100
    }

}

extension ExampleViewController: Eddystone.ScannerDelegate {
    
    func eddystoneNearbyDidChange() {
        self.previousUrls = self.urls
        self.urls = Eddystone.Scanner.nearbyUrls
        
        self.mainTableView.switchDataSourceFrom(self.previousUrls, to: self.urls, withAnimation: .top)
    }
    
}


extension ExampleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleTableViewCell") as! ExampleTableViewCell
        
        let url = self.urls[indexPath.row]
        
        cell.mainLabel.text = url.url.absoluteString
        
        if  let battery = url.battery,
            let temp = url.temperature,
            let advCount = url.advertisementCount,
            let onTime = url.onTime {
                cell.detailLabel.text = "Battery: \(battery)% \nTemp: \(temp)˚C \nPackets Sent: \(advCount) \nUptime: \(onTime.readable)"
        } else {
            cell.detailLabel.text = "No telemetry data"
        }
        
        
        
        switch url.signalStrength {
        case .excellent: cell.signalStrengthView.signal = .Excellent
        case .veryGood: cell.signalStrengthView.signal = .VeryGood
        case .good: cell.signalStrengthView.signal = .Good
        case .low: cell.signalStrengthView.signal = .Low
        case .veryLow: cell.signalStrengthView.signal = .VeryLow
        case .noSignal: cell.signalStrengthView.signal = .NoSignal
        default: cell.signalStrengthView.signal = .Unknown
        }
    
        return cell
    }
    
}

extension ExampleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
