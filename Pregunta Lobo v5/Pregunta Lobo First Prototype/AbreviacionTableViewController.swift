//
//  SegundoTableViewAsociacionesViewController.swift
//  Pregunta Lobo First Prototype
//
//  Created by Mac Mini on 10/12/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit

class AbreviacionTableViewController: UITableViewController {
    
    @IBOutlet var tablaDeAsociaciones2: UITableView!
    
    var abreviacionModel = AbreviacionModel()
    var abreviaciones = [String]()
    var categoria = String()
    var asociacionEscogida = String()
    let asociacionesFile = WriteToTextFile(fileNameEntered: "Asociaciones.txt")
    
    // llenar el table view con la informacion de asociaciones
    // desde la base de datos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        abreviaciones = abreviacionModel.getAbreviacionesFromDataBase(categoria)
        navigationItem.title = categoria
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return abreviaciones.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = abreviaciones[indexPath.row]
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) {
            cell.textLabel!.font = UIFont(name: "Arial", size: 19)
        }
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            cell.textLabel!.font = UIFont(name: "Arial", size: 25)
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        asociacionEscogida = abreviaciones[indexPath.row]
        tablaDeAsociaciones2.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "AsocToInfoSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! InfoViewController
        destinationVC.categoriaEscogida = categoria
        destinationVC.abreviacionEscogida = asociacionEscogida
        asociacionesFile.writeToFile("***************Feedback De Asociaciones****************", stringToFile: asociacionEscogida + "\n")
    }
}
