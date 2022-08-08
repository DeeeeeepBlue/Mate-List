//
//  RGBColor.swift
//  checkMate
//
//  Created by 한상윤 on 2022/03/09.
//

import Foundation
import UIKit

extension UIColor {

    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, a: Int = 0xFF) {

        self.init(

            red: CGFloat(red) / 255.0,

            green: CGFloat(green) / 255.0,

            blue: CGFloat(blue) / 255.0,

            alpha: CGFloat(a) / 255.0

        )

    }

 

    convenience init(rgb: CGFloat) {

           self.init(

            red: (Int(rgb) >> 16) & 0xFF,

            green: (Int(rgb) >> 8) & 0xFF,

            blue: Int(rgb) & 0xFF

           )

       }

    

    // let's suppose alpha is the first component (ARGB)

    convenience init(argb: CGFloat) {

        self.init(

            red: (Int(argb) >> 16) & 0xFF,

            green: (Int(argb) >> 8) & 0xFF,

            blue: Int(argb) & 0xFF,

            a: (Int(argb) >> 24) & 0xFF

        )

    }

}
