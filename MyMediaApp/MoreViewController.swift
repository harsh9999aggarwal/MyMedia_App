//
//  UserScreenViewController.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 28/04/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var appThemeLabel: UILabel!
    @IBOutlet weak var logOutUIButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        logOutUIButton.layer.cornerRadius = 12
        logOutUIButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTouchUpInside ( _ sender : Any) {
        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
    }
    
    @IBAction func themeSwitchTouchUpInside( _ sender :UISwitch){
        Theme.current = sender.isOn ? LightTheme() : DarkTheme()
        UserDefaults.standard.set(sender.isOn, forKey: "Theme")
        applyTheme()
    }
    
    fileprivate func applyTheme() {
        view.backgroundColor = Theme.current.background
        appThemeLabel.textColor = Theme.current.textColor
        appThemeLabel.font = Theme.current.mainFontName
        appThemeLabel.backgroundColor = Theme.current.accent
    }
    
}
