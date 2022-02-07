//
//  DevicesViewCell.swift
//  BluetoothExample
//
//  Created by Sequeira, Primal Carol on 21/01/22.
//

import UIKit

class DevicesViewCell: UITableViewCell {
    
    @IBOutlet weak var connectionBtn: UIButton!
    
    @IBOutlet weak var innerView: UIView!
    var devicesList: [String] = []
    @IBOutlet weak var deviceName: UILabel!
    
    
//    @IBInspectable var cornerRadius: CGFloat = 30
//
//    @IBInspectable var shadowOffsetWidth: Int = 10
//    @IBInspectable var shadowOffsetHeight: Int = 3
//    @IBInspectable var shadowColor: UIColor? = UIColor.white
//    @IBInspectable var shadowOpacity: Float = 0.2
//
//    override func layoutSubviews() {
//        innerView.layer.cornerRadius = cornerRadius
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
//
//
//        innerView.layer.cornerRadius = cornerRadius
//        innerView.layer.masksToBounds = false
//        innerView.layer.shadowColor = shadowColor?.cgColor
//        innerView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
//        innerView.layer.shadowOpacity = shadowOpacity
//        innerView.layer.borderWidth = 3.0
//        innerView.layer.borderColor = UIColor.orange.cgColor
//
//        }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(name: String, conntype: String) {
        deviceName.text = "\(name)"
        connectionBtn.setTitle("\(conntype)", for: .normal)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
