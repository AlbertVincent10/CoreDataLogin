//
//  ViewController.swift
//  CoreDataLogin
//
//  Created by albert Michael on 17/04/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
 
    @IBOutlet weak var text1: UITextField!
    
    @IBOutlet weak var text2: UITextField!
    
   
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var Context : NSManagedObjectContext?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Context = appDelegate.persistentContainer.viewContext
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        guard let name = self.text1.text, name != "" else {
            print ("name is empty")
            return
        }
        guard let password = self.text2.text, password != "" else {
            print ("password is empty")
            return
        }
        self.Fetch(name: name, password: password)
       
    }
    
    
    func Save(name : String, password : String)  {
        let login = NSEntityDescription.insertNewObject(forEntityName: "Login", into: Context!)
        login.setValue(name, forKey: "name")
        login.setValue(password, forKey: "password")
        do{
            try Context?.save()
            print("successfully----")
           
        }catch{
            print("error----")
        }
    }
    func Fetch(name: String, password: String){
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        request.predicate = NSPredicate(format: "name = %@",name )
        request.predicate = NSPredicate(format: "password = %@",password)
        //request.returnsObjectsAsFaults = false
        do{
            let results = try Context?.fetch(request)
            let count = results?.count
            
            if 0 < count! {
                for result in results! as! [NSManagedObject]{
                    if  let name = result.value(forKey: "name") as? String{
                        print("Name=\(name)")
                        let loginVc = self.storyboard?.instantiateViewController(withIdentifier: "DisplayViewController") as! DisplayViewController
                        self.present(loginVc, animated: true, completion: nil)
                    }
                    
                }
                

            }
            else {
                print("User Not Found")
                let alert = UIAlertController(title: "Username and Password", message: "Enter correct credentials", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Click", style:.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
            }
        }catch{
        }
        
    }
    
    @IBAction func signupButton(_ sender: Any) {
       
    }
    

}

