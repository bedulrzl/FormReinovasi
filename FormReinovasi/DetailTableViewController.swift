//
//  DetailTableViewController.swift
//  FormReinovasi
//
//  Created by Aprizal on 12/12/20.
//  Copyright © 2020 Aprizal. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit

class DetailTableViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableCell", for: indexPath) as? DetailTableViewCell
        cell?.delegate = self
        let itemDetail = itemArray[indexPath.row]
        
        cell?.nameForm?.text = itemDetail.name
        cell?.emailForm?.text = itemDetail.email
        cell?.lahirForm?.text = itemDetail.tanggalLahir
        cell?.jenisForm?.text = itemDetail.jenisKelamin
        
        return cell!
        
    }
    

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func loadItem(){
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try   context.fetch(request)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    
}

extension DetailTableViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
       
            self.context.delete(self.itemArray[indexPath.row])
            self.itemArray.remove(at: indexPath.row)
           
//            tableView.reloadData()
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
//        options.transitionStyle = .border
        
        return options
    }
    
    
}
