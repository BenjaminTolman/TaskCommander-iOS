//
//  Job.swift
//  TaskCommander
//
//  Created by Benjamin Tolman on 3/27/22.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class Job{
    
    public var jobTitle: String = ""
    public var jobAddress: String = ""
    public var jobStatus: String = ""
    public var jobHour: Int = 0
    public var jobMin: Int = 0
    public var jobDay: Int = 0
    public var jobMonth: Int = 0
    public var jobYear: Int = 0
    public var jobNotes: String = ""
    public var clientName: String = ""
    public var companyCode: String = ""
    public var assigned: String = ""
    
    
    
}
