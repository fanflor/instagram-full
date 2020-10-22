//
//  LogInViewController.swift
//  instagram
//
//  Created by searto  on 10/14/20.
//

import UIKit
import Parse
class LogInViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnSignin(_ sender: Any)
    {
        let username = usernameField.text!
        let password = passwordField.text!
        PFUser.logInWithUsername(inBackground: username, password: password)
        {
         (user, error) in
            if user != nil
            {
                self.performSegue(withIdentifier: "loginSEG", sender: nil)
            }else
            {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    
    @IBAction func OnSignup(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text

        user.signUpInBackground{(succes,error)in
            if succes{
                self.performSegue(withIdentifier: "loginSEG", sender: nil)
            }
            else{
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
