//
//  UIFont+Extension.swift
//  SEStatus
//
//  Created by Jaydeep on 03/06/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

enum themeFonts : String
{
    case regular = "Quicksand-Regular"
    case semibold = "Quicksand-SemiBold"
    case bold = "Quicksand-Bold"
    case light = "Quicksand-Light"
    case medium = "Quicksand-Medium"
}

extension UIFont
{
    
}

func themeFont(size : Float,fontname : themeFonts) -> UIFont
{
    if UIScreen.main.bounds.width <= 320
    {
        return UIFont(name: fontname.rawValue, size: CGFloat(size) - 2.0)!
    }
    else
    {
        return UIFont(name: fontname.rawValue, size: CGFloat(size))!
    }
}
