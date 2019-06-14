//
//  DocumentTableViewController.swift
//  Documents
//
//  Created by BryceLigaya on 6/10/19.
//  Copyright © 2019 Bl223LabCPU. All rights reserved.
//

import UIKit
import CoreData

class DocumentTableViewController: UITableViewController {

    var docs = [Document]()
    
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        fetchDocs()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "docTableViewCell", for: indexPath) as! docTableViewCell
        
        let doc: Document = docs[indexPath.row]
        cell.configureCell(doc: doc)
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt cindexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
                let delete = UITableViewRowAction(style: .destructive, title: "                    ") { (action, indexPath) in
                    
                    let docs = self.docs[indexPath.row]
                    context.delete(docs)
                    
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    do {
                        self.docs = try context.fetch(Document.fetchRequest())
                    }
                        
                    catch {
                        print("Failed to delete Document.")
                    }
                    
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.reloadData()
                    
                }
//            tableView.deleteRows(at: [indexPath], with: .fade)
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
                return [delete]
        }
            
    }
//        func fetchDocs() {
//            managedObjectContext?.perform {
//
//                self.fetchDocsFromCoreData { (docs) in   //ERROR ON THIS LINE I DONT UNDERSTAND It states "Value of type 'DocumentTableViewController' has no member 'fetchDocsFromCoreData'" when FetchDocsFromCoreData is clearly located in the func below this statement
//                    if let docs = docs {
//                        self.docs = docs
//                        self.tableView.reloadData()
//
//                    }
//
//                }
//
//            }
//
//        }
        
        func fetchDocsFromCoreData(completion: @escaping ([Document]?)->Void){
            managedObjectContext?.perform {
                var docs = [Document]()
                let request: NSFetchRequest<Document> = Document.fetchRequest()
                
                do {
                    docs = try  self.managedObjectContext!.fetch(request)
                    completion(docs)
                    
                }
                    
                catch {
                    print("Could not Find Documentation:\(error.localizedDescription)")
                    
                }
                
            }
            
        }
        
    }
    



}

