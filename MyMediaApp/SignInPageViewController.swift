//
//  SignInPageViewController.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 28/04/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import UIKit
import CoreData
import FBSDKLoginKit
import GoogleSignIn



class SignInPageViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var passwordUILabel: UILabel!
    @IBOutlet weak var usernameUILabel: UILabel!
    @IBOutlet weak var signInUIButton: UIButton!
    @IBOutlet weak var signUpUIButton : UIButton! 
    @IBOutlet weak var fbLoginButton: FBLoginButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        signInUIButton.layer.cornerRadius = 12
        signInUIButton.layer.masksToBounds = true
        signUpUIButton.layer.cornerRadius = 12
        signUpUIButton.layer.masksToBounds = true
        fbLoginButton.layer.cornerRadius = 12
        fbLoginButton.layer.masksToBounds = true
        googleLoginButton.layer.cornerRadius = 12
        googleLoginButton.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
        facebookLogin()
        //googleLogin()
        
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
                   //user is already logged in
                   
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let mainTabBarController = storyboard.instantiateViewController(identifier: "TabBarController")
                   
               // This is to get the SceneDelegate object from your view controller
               // then call the change root view controller function to change to main tab bar
               (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        } 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func facebookLogin(){
        if let token = AccessToken.current,
           !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (connection, result, error) in
                print("\(result)")
            }
        }else{
            fbLoginButton.permissions = ["public_profile", "email"]
            fbLoginButton.delegate = self
        }
    }
    
    func googleLogin(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        if GIDSignIn.sharedInstance().hasPreviousSignIn(){
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            print("Already Login")
        }
    }
    
    @IBAction func signUpTouchUpInside(_ sender : Any){
        let vc = storyboard?.instantiateViewController(identifier: "SignUpPageViewController") as! SignUpPageViewController
        self.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func googleLoginTouchUpInside(_ sender :Any){
        googleLogin()
        GIDSignIn.sharedInstance()?.signIn()
       
    }
    
    @IBAction func signInTouchUpInside(_ sender: Any) {
        
      let userdetail = CoreDataManager.shared.fetchUserDetails(withEmail: usernameInput!.text ?? "")
      ValidationCode()
      if userdetail?.password == passwordInput!.text {
              
              UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
              
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let mainTabBarController = storyboard.instantiateViewController(identifier: "TabBarController")
              
              // This is to get the SceneDelegate object from your view controller
              // then call the change root view controller function to change to main tab bar
              (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
    }
}

extension SignInPageViewController{
    fileprivate func ValidationCode() {
        if let email = usernameInput.text, let password = passwordInput.text{
            if !email.validateEmailId(){
                openAlert(title: "Alert", message: "Email address not found.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Please enter valid password (8 char containing minimum 1 alphabet & 1 number)", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }else{
                // Navigation - Home Screen
            }
        }else{
            openAlert(title: "Alert", message: "Please add detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
    }
}

extension SignInPageViewController: LoginButtonDelegate{
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        //facebookLogin()
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(String(describing: result))")
        }
        UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "TabBarController")
        
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
    }
}

extension SignInPageViewController: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "TabBarController")
        
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
    
    
}
