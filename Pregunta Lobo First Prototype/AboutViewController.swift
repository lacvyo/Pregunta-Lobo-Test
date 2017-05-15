//
//  AboutViewController.swift
//  Pregunta Lobo First Prototype
//
//  Created by Mac Mini on 9/25/15.
//  Copyright © 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var comentariosTextField: UITextField!
    
 
    @IBOutlet weak var starRatingView: CosmosView!
  
   
    @IBOutlet weak var creditosView: UIView!
    @IBOutlet weak var creditosTextView: UITextView! {
        didSet {
            creditosTextView.text = text
        }
    }
    
    var ratingToSend = Double()
    
    
    var userFeedbackFile = WriteToTextFile(fileNameEntered: "User_Feedback.txt")
    
    var text: String = "iOS\nAmaury Rodríguez Rivera\n Cheylianie Rivera Maldonado\n Yaraliz Mercado Bernier\n Krystal N. Medina Ríos\n Erick Rivera Cruz\n Alexander Rivera Rivera\n\nAndroid (original)\nAna C. Rodríguez Medina\nAngélica M. Rosario Maisonet\nCarlos Nieves Cardona\nDaniel Damudt Galera\nDelma I. Nieves Rivera\nEmmanuel Castro Soto\nEzequiel Santos Freytes\nFrankie Coll Valera\nSamuel Santiago Soto" {
        // óáéíú
        didSet {
            creditosTextView.text = text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.comentariosTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AboutViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        // Para que el borde de los objetos en el view se vea rounded
        
        var cornerRadius:CGFloat = 0
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) {
            cornerRadius = 10
        }
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            cornerRadius = 20
        }
        
        creditosView.layer.cornerRadius = cornerRadius
        creditosView.clipsToBounds = true
        
        comentariosTextField.layer.cornerRadius = cornerRadius
        comentariosTextField.clipsToBounds = true
        
        
        // Star Rating
        
        // Called when user finishes changing the rating by lifting the finger from the view.
        // This may be a good place to save the rating in the database or send to the server.
        
        
     
        starRatingView.didTouchCosmos = didTouchCosmos
  
    }
    
    // En el iPad todo funciona perf
    
    
    // En el iPhone
    // Funciona pero no se guarda nadaaa en los archivos. Ni siquiera los borra al correr la aplicacion 
    
    
    func didTouchCosmos(_ rating: Double) {
        print("Touching Cosmos. Rating: \(rating)")
       ratingToSend = rating
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("creating Star Rating file")
        
        let starRatingFile = WriteToTextFile(fileNameEntered: "Star_Rating.txt")
        
        starRatingFile.writeToFile("******************Star Ratings*******************", stringToFile: "Rating: \(ratingToSend)\n")
        
        print("Wrote to file: \(ratingToSend)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Quitar el keyboard con la tecla return.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        tapSend()
        return false
    }
    
    func tapSend() {
        let text = "Feedback: " + comentariosTextField.text!
        userFeedbackFile.writeToFile("***************User Feedback****************", stringToFile: text + "\n")

    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

}
