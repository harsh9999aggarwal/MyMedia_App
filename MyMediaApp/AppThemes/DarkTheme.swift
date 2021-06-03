//
//  DarkTheme.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 02/05/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import UIKit

class DarkTheme: ThemeProtocol {
    
    var textColor: UIColor = UIColor.white
    var mainFontName: UIFont = UIFont(name: "Arial", size: 20)!
    var accent: UIColor =  UIColor(named: "background")!
    var background: UIColor =  UIColor(named: "tint")!
    var tint: UIColor = UIColor(named: "accent")!
}
