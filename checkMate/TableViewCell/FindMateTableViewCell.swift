//
//  FindMateTableViewCell.swift
//  checkMate
//
//  Created by DOYEONLEE2 on 2022/03/08.
//

import UIKit

class FindMateTableViewCell: UITableViewCell {

    @IBOutlet weak var suitableBackground: UIView!
    @IBOutlet weak var suitableText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        setSuitableLabelGradient(view: suitableBackground, label: suitableText)
        suitableText?.text = "준비중"
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSuitableLabelGradient(view:UIView, label:UILabel){

        // Create a gradient layer
        weak var gradient = CAGradientLayer()

        // gradient colors in order which they will visually appear
        gradient?.colors = [UIColor(rgb: 0x6795CF).cgColor, UIColor(rgb: 0x6764EE).cgColor]

        // Gradient from left to right
        gradient?.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient?.endPoint = CGPoint(x: 1.0, y: 1.0)

        // set the gradient layer to the same size as the view
        gradient?.frame = view.bounds
        // add the gradient layer to the views layer for rendering
        view.layer.addSublayer(gradient!)

        view.mask = label
    }

}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }

    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}

extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}
