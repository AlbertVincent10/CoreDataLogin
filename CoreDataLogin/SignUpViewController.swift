//
//  SignUpViewController.swift
//  CoreDataLogin
//
//  Created by albert Michael on 18/04/22.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var Context : NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupButton(_ sender: Any) {
        guard let name = self.nameTextFiled.text, name != "" else {
            print ("name is empty")
            return
        }
        guard let password = self.passwordTextField.text, password != "" else {
            print ("password is empty")
            return
        }
        self.Save(name: name, password: password)
        
    }
    func Save(name : String, password : String)  {
        let login = NSEntityDescription.insertNewObject(forEntityName: "Login", into: Context!)
        login.setValue(name, forKey: "name")
        login.setValue(password, forKey: "password")
        do{
            try Context?.save()
            print("successfully")
            let alert = UIAlertController(title: "Signup Successfully", message: "Try to Login", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "ok", style:.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
           
        }catch{
            print("error----")
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
