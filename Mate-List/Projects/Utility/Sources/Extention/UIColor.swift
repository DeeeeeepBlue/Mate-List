//
//  UIColor.swift
//  checkMate
//
//  Created by DOYEONLEE2 on 2022/03/07.
//
import Foundation
import UIKit

public extension UIColor {

    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {

        self.init(

            red: CGFloat(red) / 255.0,

            green: CGFloat(green) / 255.0,

            blue: CGFloat(blue) / 255.0,

            alpha: CGFloat(a) / 255.0

        )

    }

 

    convenience init(rgb: Int) {

           self.init(

               red: (rgb >> 16) & 0xFF,

               green: (rgb >> 8) & 0xFF,

               blue: rgb & 0xFF

           )

       }

    

    // let's suppose alpha is the first component (ARGB)

    convenience init(argb: Int) {

        self.init(

            red: (argb >> 16) & 0xFF,

            green: (argb >> 8) & 0xFF,

            blue: argb & 0xFF,

            a: (argb >> 24) & 0xFF

        )

    }

}

public extension UIColor {

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
    
    //MARK: 자주 쓰는 색
    class var mainGrey : UIColor { UIColor(rgb: 0xE5E5E5) }
    class var mainblue : UIColor { UIColor(rgb: 0x4C81E9) }

}
