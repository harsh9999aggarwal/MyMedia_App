//
//  SignUpPageViewController.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 28/04/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import UIKit
import CoreData

class SignUpPageViewController: UIViewController {

    
    @IBOutlet weak var firstNameUILabel: UILabel!
    @IBOutlet weak var lastNameUILabel: UILabel!
    @IBOutlet weak var usernameUILabel: UILabel!
    @IBOutlet weak var passwordUILabel: UILabel!
    @IBOutlet weak var dobUILabel: UILabel!
    
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!   // it can be email too
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var dobInput: UIDatePicker!
    @IBOutlet weak var signUpUIButton: UIButton!
 
    var newUserData = [NewUserData?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        signUpUIButton.layer.cornerRadius = 12
        signUpUIButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        dobInput.datePickerMode = .date
        dobInput.preferredDatePickerStyle = .wheels
    }
    
    @IBAction func signUpTouchUpInside (_ sender: Any){
        if let email = emailInput.text, let password = passwordInput.text, let firstName = firstNameInput.text, let lastName = lastNameInput.text, let conPassword = passwordInput.text{
            if firstName == ""{
                openAlert(title: "Alert", message: "Please enter your First Name", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("Please enter your First Name")
                
            }else if lastName == ""{
                openAlert(title: "Alert", message: "Please enter your Last Name", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("Please enter your Last Name")
                
            }else if !email.validateEmailId(){
                openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("email is not valid")
                
            }else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Please enter valid password (8 char containing minimum 1 alphabet & 1 number)", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("Password is not valid")
                
            } else{
                if conPassword == ""{
                    openAlert(title: "Alert", message: "Please confirm your password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    print("Please confirm password")
                }else{
                    if password == conPassword{
                        // navigation code
                        newUserData = [CoreDataManager.shared.createUserDetails(firstName: firstNameInput!.text ?? "", lastName: lastNameInput!.text ?? "", email: emailInput!.text ?? "", password: passwordInput!.text ?? "", dateOfBirth: dobInput!.date)]
                        //        print("usedata = \(String(describing: userData[0]))")
                        //        print("\(UserData.self)")
                        
                        self.dismiss(animated: true, completion: nil)
                        print("Navigation code Yeah!")
                    }else{
                        openAlert(title: "Alert", message: "Password and Confirm Password fields do not match", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                        print("password does not match")
                    }
                }
            }
        }else{
            print("Please check your details")
        }
    }
    
}
