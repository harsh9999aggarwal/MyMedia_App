//
//  ThemeProtocol.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 02/05/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var mainFontName : UIFont { get }
    var textColor: UIColor { get }
    var accent: UIColor { get }
    var background: UIColor { get }
    var tint: UIColor { get }
}
