//
//  FilterTableViewCell.swift
//  checkMate
//
//  Created by 한상윤 on 2022/02/04.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    var checkMark: String = "checkmark.circle"
    
    @IBOutlet weak var checkButton: UIButton!
    
    var check:Bool = true
    
    @IBAction func checkButtonAction(_ sender: UIButton) {
        check = !check
        if check {
            checkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            checkMark = "checkmark.circle"
            print(check)
//            print(scrapFilter)
        } else {
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            checkMark = "checkmark.circle.fill"
            print(check)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        checkButton.setImage(UIImage(named: "checkmark.circle"), for: .normal)
        checkButton.setImage(UIImage(systemName: checkMark), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


        // Configure the view for the selected state
    }
    
//    override var isSelected: Bool {
//        super.isSelected
//        print("click")
//
//    }
    

}
