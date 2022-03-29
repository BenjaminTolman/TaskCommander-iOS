//
//  ViewController.swift
//  TaskCommander
//
//  Created by Benjamin Tolman on 3/15/22.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class ViewController: UIViewController {

    private let store = Firestore.firestore()
    
    //This property will go to Jobs page through segue.
    private var loginEmail: String = ""
    
    //Not sure yet, need an arraylist?
    public var employees = [Employee]()
    public var jobs = [Job]()
    
    @IBOutlet weak var name_login: UITextField!
    @IBOutlet weak var password_login: UITextField!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    @IBAction func button(_ sender: UIButton) {
        if sender == button{
            
        let name: String = name_login.text ?? ""
        let pass: String = password_login.text ?? ""
        
            //Set the email for jobs window.
            if(name != "" && pass != ""){
                loginEmail = name
                logIn(email: name, password: pass)
            }
            else{
                print("Please fill in name and password")
            }
            //let vc = self.storyboard?.instantiateViewController(withIdentifier: "jobsVC") as! JobsViewController
             //   self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getEmployees()
        
        //let jobsViewController = storyboard?.instantiateViewController(withIdentifier: "jobsVC") as! JobsViewController
        //present(jobsViewController, animated: true)
        //createRestaurant(restaurantName: "Zimbabo's")
        // Do any additional setup after loading the view.
    }
    
    func createRestaurant(restaurantName: String) {
        let db = Firestore.firestore()

        let docRef = db.collection("Restaurants").document(restaurantName)

        docRef.setData(["name": restaurantName]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func getEmployees() {
        let db = Firestore.firestore()

        let docRef = db.collection("users").document("manager@gmail.com")

        docRef.getDocument { (document,error) in
            if let document = document, document.exists{
                
                let employee = Employee()
                
                let property = document.get("companycode")
                if let ccode: String = property as? String {
                    employee.companyCode = ccode
                    print("Document Data:  \(employee.companyCode)")
                }
            }
        }
    }
    
    func logIn(email: String, password: String){
        let db = Firestore.firestore()

        let docRef = db.collection("users").document(email)

        docRef.getDocument { (document,error) in
            if let document = document, document.exists{
            
                let passwordProp = document.get("password")
                if let pProp: String = passwordProp as? String {
                    if(pProp == password){
                        self.performSegue(withIdentifier: "jobsSegue", sender: Any?.self)
                    }
                    else{
                        print("Password is incorrect")
                    }
                
                
                //let employee = Employee()
                
                //let property = document.get("companycode")
                //if let ccode: String = property as? String {
                //    employee.companyCode = ccode
                //   print("Document Data:  \(employee.companyCode)")
                //}
            }
            }else{
                print("Email does not exist, please register")
            }
    }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "jobsSegue") {
                let vc = segue.destination as! JobsViewController
                vc.currentUser = loginEmail
            }
    }
}

