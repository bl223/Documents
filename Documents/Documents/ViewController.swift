//
//  ViewController.swift
//  Documents
//
//  Created by BryceLigaya on 6/10/19.
//  Copyright © 2019 Bl223LabCPU. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var DocumentViewview: UIView!
    @IBOutlet weak var labelDocName: UITextField!
    @IBOutlet weak var docDescriptionView: UITextView!
    
    
        var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    }
    
    var docFetchedResultsController: NSFetchedResultsController<Document>!
    
    var doc = [Document]()
    var docs: Document?
    var isExisting = false
    var indexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let docs = docs {
            
            labelDocName.text = docs.docName
            docDescriptionView.text = docs.docDescription
            
        }
       
        if labelDocName.text != "" {
            isExisting = true
        }
        
        labelDocName.delegate = self
        docDescriptionView.delegate = self
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func saveToCoreData(completion: @escaping ()->Void){
        managedObjectContext!.perform {
            do {
                try self.managedObjectContext?.save()
                completion()
                print("Document Saved.")
                
            }
                
            catch let error {
                print("Could not be Saved \(error.localizedDescription)")
                
            }
    
        }
    }
}
