//
//  MyTableViewCell.swift
//  mycheckmate
//
//  Created by 김가은 on 2022/02/06.
//

import UIKit
import DropDown


class SurveyInputViewCell: UITableViewCell {
    
    var check : Bool = false
    let color = UIColor(rgb: 0xDBEBFF)
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var check_B: UIButton!
    @IBOutlet weak var backView: UIView!
    
    @IBAction func clicked(_ sender: Any) {
        check = !check
        if check { //true
            check_B.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            backView.backgroundColor=color
        }else{
            check_B.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            backView.backgroundColor=UIColor.white
        }
        
        if myLabel.text == "흡연"{
            smokingSelect=check
        } else if myLabel.text == "게임"{
            gameSelect=check
            print(gameSelect)
        }else if myLabel.text == "코골이"{
            snoringSelect=check
        }else if myLabel.text == "이갈이"{
            griding_teethSelect=check
        }else if myLabel.text == "방에서 통화"{
            callSelect=check
        }else if myLabel.text == "방에서 음식섭취"{
            eatSelect=check
        }else if myLabel.text == "귀가 시간(11시 이후)"{
            curfewSelect=check
        }else if myLabel.text == "취침 시간(12시 이후)"{
            bedtimeSelect=check
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
        setDropdown()
        tfInput.layer.borderColor=UIColor.blue.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    let dropDown = DropDown()
    let clean_itemList = ["0회","1회","2회","3회","4회","5회","6회","매일"]
    let mbti_itemList = ["ISTJ","ISFJ","INFJ","INTJ","ISTP","ISFP","INFP","INTP","ESTP","ESFP","ENFP","ENTP","ESTJ","ESFJ","ENFJ","ENTJ"]
    
    func initUI() {
        dropView.backgroundColor = UIColor.init(named: "gray")
        dropView.layer.cornerRadius = 8
        DropDown.appearance().textColor=UIColor.black
        DropDown.appearance().selectedTextColor=UIColor.blue
        DropDown.appearance().backgroundColor=UIColor.white
        DropDown.appearance().selectionBackgroundColor=color
        DropDown.appearance().setupCornerRadius(8)
        dropDown.dismissMode = .automatic
        tfInput.text="선택"
        btnSelect.titleLabel?.text = ""
        check_B.titleLabel?.text = ""
    }
    
    
    func setDropdown() {
        // dataSource로 ItemList를 연결
        if myLabel.text == "청소주기"{
            dropDown.dataSource = clean_itemList
        }else {
            dropDown.dataSource = mbti_itemList
        }

        // anchorView를 통해 UI와 연결
        dropDown.anchorView = self.dropView
        
        // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
        dropDown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        
        // Item 선택 시 처리
        dropDown.selectionAction = { [weak self] (index, item) in
            //선택한 Item을 TextField에 넣어준다.
            self!.tfInput.text = item
            if self!.myLabel.text == "청소주기"{
                cleanSelect=item
                print(cleanSelect)
            } else if self!.myLabel.text == "mbti"{
                mbtiSelect=item
                print(mbtiSelect)
            }

            self?.backView.backgroundColor=self?.color
        }
}
    
    @IBAction func dropdownClicked(_ sender: Any) {
            dropDown.show() // 아이템 팝업을 보여준다.
        setDropdown()
    }
    
    
    

}
