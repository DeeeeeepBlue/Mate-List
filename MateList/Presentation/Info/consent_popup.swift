//
//  consent_popup.swift
//  checkMate
//
//  Created by 김가은 on 2022/04/01.
//

import UIKit

class consent_popup: UIViewController {

    @IBOutlet var backview: UIView!
    var viewBlurEffect:UIVisualEffectView!

    
    @IBAction func closePopupBtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)  // 사라지게 하기
        print("#사라지게하기")


    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBlurEffect = UIVisualEffectView()

        //Blur Effect는 .light 외에도 .dark, .regular 등이 있으니 적용해보세요!
        viewBlurEffect.effect = UIBlurEffect(style: .regular)
                
    }
            
    @IBAction func agreepopupBtn(_ sender: Any) {
        print("#동의하기")
        new_mem_agree=1
        self.dismiss(animated: false, completion: nil)  // 사라지게 하기
    }
    
}
