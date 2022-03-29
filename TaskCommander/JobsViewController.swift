//
//  JobsViewController.swift
//  TaskCommander
//
//  Created by Benjamin Tolman on 3/28/22.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class JobsViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    
    // Data model: These strings will be the data for the table view cells
    var jobTitles: [String] = []
    let colors = [UIColor.blue, UIColor.yellow, UIColor.magenta]
    
    public var jobs = [Job]()
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    public var currentUser: String = ""
    //var employeeClass: Employee?
    
    public var companyCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(currentUser)
        
        self.tableView.dataSource = self
            self.tableView.delegate = self
            
            self.registerTableViewCells()
        
        
        getEmployee(userEmail: currentUser)
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "MyCustomCell",
                                  bundle: nil)
        self.tableView.register(textFieldCell,
                                forCellReuseIdentifier: "MyCustomCell")
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jobTitles.count
    }
    
    // create a cell for each table view row
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell") as? MyCustomCell {
                    
                    
                    
                    var currentJob: Job = self.jobs[indexPath.row]
                    
                    var ampm: String = "AM"
                    var month: String = "None"
                    
                    if(currentJob.jobMonth == 0){month = "Jan"}
                    if(currentJob.jobMonth == 1){month = "Feb"}
                    if(currentJob.jobMonth == 2){month = "Mar"}
                    if(currentJob.jobMonth == 3){month = "Apr"}
                    if(currentJob.jobMonth == 4){month = "May"}
                    if(currentJob.jobMonth == 5){month = "Jun"}
                    if(currentJob.jobMonth == 6){month = "Jul"}
                    if(currentJob.jobMonth == 7){month = "Aug"}
                    if(currentJob.jobMonth == 8){month = "Sep"}
                    if(currentJob.jobMonth == 9){month = "Oct"}
                    if(currentJob.jobMonth == 10){month = "Nov"}
                    if(currentJob.jobMonth == 11){month = "Dec"}
                    
                    //Time
                    if(currentJob.jobHour > 12){
                        ampm = "PM"
                        currentJob.jobHour = currentJob.jobHour - 12
                    }
                    
                    //todo add 0 if min is < 10
                    if(currentJob.jobStatus == "Complete"){
                        cell.jobStatus_text.textColor = UIColor.red
                    }
                    if(currentJob.jobStatus == "Posted"){
                        cell.jobStatus_text.textColor = UIColor.green
                    }
                    if(currentJob.jobStatus == "In Progress"){
                        cell.jobStatus_text.textColor = UIColor.yellow
                    }
                    
                    cell.jobtitle_text?.text = currentJob.jobTitle
                    cell.jobAddress_text?.text = currentJob.jobAddress
                    cell.jobTimeDate_text?.text =
                    String(currentJob.jobDay) + " " + month + " " + String(currentJob.jobYear) + "  " + String(currentJob.jobHour) + ":" + String(currentJob.jobMin) + " " + ampm
                    
                    cell.jobNotes_text?.text = currentJob.jobNotes
                    cell.jobClientName_text?.text = "Client: " + currentJob.clientName
                    cell.jobAssigned_text?.text = "Assigned to: " + currentJob.assigned
                    cell.jobStatus_text?.text = currentJob.jobStatus
                    
                    
                    return cell
                }
                
                return UITableViewCell()
        }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
func getEmployee(userEmail: String) {
    print("MADE")
    let db = Firestore.firestore()
    
    let docRef = db.collection("users").document(userEmail)
    
    docRef.getDocument { (document,error) in
        if let document = document, document.exists{
            
            //let employee = Employee()
            
            let property = document.get("companycode")
            if let ccode: String = property as? String {
                print("MADE")
                self.companyCode = ccode
                self.getJobs(code: ccode)
                //print("Document Data:  \(employee.companyCode)")
            }
        }
    }
}


    func getJobs(code: String) {
    let db = Firestore.firestore()
        
        db.collection("jobs").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                let newJob: Job = Job()
                   // print("\(document.documentID) => \(document.data())")
                    //let property = document.get("address")
                let property = document.documentID
                if let title: String = property as? String {
                self.jobTitles.append(title)
                newJob.jobTitle = title;
                }
                    let addressproperty = document.get("address")
                    if let address: String = addressproperty as? String {
                newJob.jobAddress = address;
                }
                    let statusproperty = document.get("status")
                    if let status: String = statusproperty as? String {
                newJob.jobStatus = status;
                }
                    let hourproperty = document.get("hour")
                    if let hour: Int =  hourproperty as? Int {
                newJob.jobHour = hour;
                }
                    let minproperty = document.get("min")
                    if let min: Int = minproperty as? Int {
                newJob.jobMin = min;
                }
                    let dayproperty = document.get("day")
                    if let day: Int = dayproperty as? Int {
                newJob.jobDay = day;
                }
                    let monthproperty = document.get("month")
                    if let month: Int = monthproperty as? Int {
                newJob.jobMonth = month;
                }
                    let yearproperty = document.get("year")
                    if let year: Int = yearproperty as? Int {
                newJob.jobYear = year;
                }
                    let notesproperty = document.get("notes")
                    if let notes: String = notesproperty as? String {
                newJob.jobNotes = notes;
                }
                    let clientnameproperty = document.get("client")
                    if let clientname: String = clientnameproperty as? String {
                newJob.clientName = clientname;
                }
                    let companycodeproperty = document.get("companycode")
                    if let companycode: String = companycodeproperty as? String {
                newJob.companyCode = companycode;
                }
                    let assignedproperty = document.get("assigned")
                    if let assigned: String = assignedproperty as? String {
                newJob.assigned = assigned;
                }
                
                self.jobs.append(newJob)
            }
        }
            DispatchQueue.main.async { self.tableView.reloadData() }
    }
            
            
}
        
        
//
//    let docRef = db.collection("jobs").document("manager@gmail.com")
//
//
//    docRef.getDocument { (document,error) in
//        if let document = document, document.exists{
//
//            let employee = Employee()
//
//            let property = document.get("companycode")
//            if let ccode: String = property as? String {
//                employee.companyCode = ccode
//                print("Document Data:  \(employee.companyCode)")
//            }
//        }
//    }
}
    

