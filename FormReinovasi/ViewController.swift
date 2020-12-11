//
//  ViewController.swift
//  FormReinovasi
//
//  Created by Aprizal on 11/12/20.
//  Copyright © 2020 Aprizal. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, SSRadioButtonControllerDelegate {
    func didSelectButton(selectedButton: UIButton?) {
        tampung = selectedButton?.titleLabel?.text! as! String
        print(tampung)
    }
    
    var radioButtonController: SSRadioButtonsController?
    
    
    var itemArray = [Item]()
    var tampung = ""
 
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var bornInput: DateTextField!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        radioButtonController = SSRadioButtonsController(buttons: button1, button2)
        radioButtonController!.delegate = self
    }
    
    @IBAction func listBiodata(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
               self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        let newItem = Item(context: context)
        newItem.name = nameInput.text
        newItem.email = emailInput.text
        newItem.tanggalLahir = bornInput.text
        newItem.jenisKelamin = tampung
       
        
        itemArray.append(newItem);
        saveForm();
//        storyboard?.instantiateViewController(identifier: "MapCoronaViewController") as? MapCoronaViewController
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func saveForm(){
        do {
            try context.save()
        }catch {
            print(error)
        }
    }
    
    
}

