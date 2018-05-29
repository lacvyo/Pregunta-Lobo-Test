//
//  AsociacionesViewController.swift
//  Pregunta Lobo First Prototype
//
//  Created by Mac Mini on 7/9/15.
//  Copyright (c) 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    @IBOutlet var tablaDeAsociaciones: UITableView!
    
    var categoriesModel = CategoriesModel()
    var categorias = [String]()
    var selectedCategory = String()
    
    override func viewDidLoad() {
        categorias = categoriesModel.getCategoriesFromDatabase()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorias.count // cuantas celdas en el tableview se crearan
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = categorias[indexPath.row]
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) {
            cell.textLabel!.font = UIFont(name: "Arial", size: 19)
        }
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            cell.textLabel!.font = UIFont(name: "Arial", size: 25)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categorias[indexPath.row]
        tablaDeAsociaciones.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "categoryToAsocSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AbreviacionTableViewController
        destinationVC.categoria = selectedCategory
    }

}
