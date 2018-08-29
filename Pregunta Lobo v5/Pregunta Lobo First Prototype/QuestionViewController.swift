//
//  ViewController.swift
//  Pregunta Lobo First Prototype
//
//  Created by Mac Mini on 7/3/15.
//  Copyright (c) 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit
import Firebase

struct globalVariables {
     static var x = 0
}

struct test{
    static var x = 1
}

class QuestionViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var loboImagen: UIImageView!
    
    @IBOutlet weak var instrucYRespView: UIView!
    @IBOutlet weak var intruccionesYRespuestaTextView: UITextView!
    @IBOutlet weak var entreUnaPregunta: UITextField!
    
    var refInfo: DatabaseReference!
    var refHandle: DatabaseHandle?
    var topics:[Topics]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topics = TopicDataHandler.filterData()
        for topic in topics!
        {
            fetchEvents(topic: topic.topic!)
        }
        
        intruccionesYRespuestaTextView.isSelectable = true
        intruccionesYRespuestaTextView.isEditable = false
        intruccionesYRespuestaTextView.dataDetectorTypes = UIDataDetectorTypes.link
      
        self.entreUnaPregunta.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(QuestionViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        intruccionesYRespuestaTextView.text = "Escriba una pregunta acerca de la Universidad de Puerto Rico en Arecibo y presione el botón de Send en su teclado."
        
        
        // Para que los objetos en el view se vean con border redondos
        
        var cornerRadius:CGFloat = 0
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) {
            cornerRadius = 10
        }
        
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            cornerRadius = 20
            
        }
        
        instrucYRespView.layer.cornerRadius = cornerRadius
        instrucYRespView.clipsToBounds = true
        
        intruccionesYRespuestaTextView.layer.cornerRadius = cornerRadius
        intruccionesYRespuestaTextView.clipsToBounds = true
        
        entreUnaPregunta.layer.cornerRadius = cornerRadius
        entreUnaPregunta.clipsToBounds = true
       
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        loboImagen.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        loboImagen.isHidden = false
        // animacion de la imagen del lobo
        loboImagen.center = CGPoint(x: loboImagen.center.x - 400, y: loboImagen.center.y)
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.loboImagen.center = CGPoint(x: self.loboImagen.center.x + 400, y: self.loboImagen.center.y)
            
        }) 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let image2 = #imageLiteral(resourceName: "message")
        self.navigationItem.rightBarButtonItem?.image = image2
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //Quitar el keyboard con la tecla return.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        tapSend()
        return false
    }
    

    
    func tapSend() {
        if entreUnaPregunta.text != "" {
            let model = QuestionModel()
            var question = entreUnaPregunta.text!
            question += " "
            let preguntasEncontradaFile = WriteToTextFile(fileNameEntered: "Preguntas_Encontradas.txt")
            let preguntasNoEncontradaFile = WriteToTextFile(fileNameEntered: "Preguntas_No_Encontradas.txt")
            let date = Date()
            var stringSendedToFile = String()
            
            question = question.lowercased()
            question = question.folding(options: .diacriticInsensitive, locale: Locale.current)
            question = question.replacingOccurrences(of: "[`\\~\\¡\\!\\@\\#\\$\\%\\^\\&\\*\\(\\)\\-\\_\\+\\=\\[\\]\\{\\}\\\"\\|\\;\\:\\\"\\\'\\,\\<\\.\\>\\/\\¿\\?\\€\\£\\¥\\•]", with: "", options: .regularExpression)
            
            let sendedAnswer = model.checkKeywords(question)
            
            //Enviar la respuesta al UITextField
            intruccionesYRespuestaTextView.text = sendedAnswer.answer
            
            //Enviar info a los archivos.
            if sendedAnswer.answer == "No tenemos una contestación, pero evaluaremos su pregunta." {
                stringSendedToFile = "TheDelimeter\n\(date)\n" + question
                preguntasNoEncontradaFile.writeToFile("***************Preguntas No Encontradas****************", stringToFile: stringSendedToFile + "\n")
            } else {
                stringSendedToFile = "TheDelimeter\n\(date)\n" + question + "\n" + sendedAnswer.id
                preguntasEncontradaFile.writeToFile("***************Preguntas Encontradas****************", stringToFile: stringSendedToFile + "\n")
            }
        }
    }
    
    
    func fetchEvents(topic: String){
        print("Fetch Events")
        let vc = NotificationViewController()
        refInfo = Database.database().reference().child("Notification").child(topic)
        refInfo.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            if snapshot.childrenCount > 0{
                for message in snapshot.children.allObjects as![DataSnapshot]
                {
                    let messageId = message.key
                    if((vc.checkDB(id: (messageId as String?)!) == false))
                    {
                        // print("Not in DB")
                        let image =  #imageLiteral(resourceName: "messageAlert")
                        self.navigationItem.rightBarButtonItem?.image = image
                    }
                }
            }
        }) { (error) in
            print(error)
        }
    }
    
    
}

