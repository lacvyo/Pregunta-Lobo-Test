//
//  AddToCalendarViewController.swift
//  Pregunta Lobo
//
//  Created by Erick on 9/15/17.
//  Copyright © 2017 UPRA. All rights reserved.
//

import UIKit
import EventKit

class addToCalendarViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var agregarButton: buttonDesign!
    
    var getnamePopup = String()// Recoge el valor del título del evento y lo trae al popup view
    var getdescriptionPopup = String () // Recoge el valor de la descripción del evento y lo trae al popup view
    var getStartDate = Date()
    var getDoneDate = Date()
    
    var timeList: [String] = ["Ninguna","Al momento del evento", "-5 minutos", "-1 hora", "-2 hora", "-1 día"] // Lista de opciones para crear la alarma del evento
    var timeSelected:Int = -0 // Variable global para darle el tiempo a la alarma
    let NONE:Int = -1 // Constante como valor sentinela para guardar la alarma
    
    @IBOutlet weak var titlePopupLabel: UILabel!
    @IBOutlet weak var descriptionPopupLabel: UILabel!

    @IBOutlet weak var alarmPickerPopup: UIPickerView! // Lleva la lista de tiempos disponibles para la alarma
    @IBOutlet weak var alarmTextbox: UITextField! // Presenta tiempo escogido para la alarma, por default es "Ninguna"
    @IBOutlet weak var labelSDate: UILabel!
    
    @IBOutlet weak var labelDDate: UILabel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return timeList.count // Conteo de nodos en la lista para presentar en el picker view
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let title = timeList[row]
        
        return title // se le asigna el título a cada posición de la lista en el picker view
    }
    
    /*
     * En esta función se pasa el valor escogido
     * en el pickerview y se lo asignamos al textfield
     * modificando su estado actual.
     *
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.alarmTextbox.text = self.timeList[row] // Pasa el valor del picker view al textfield
        self.alarmPickerPopup.isHidden = true // Se esconde el picker view
        
        // Se verifica la opción que escoge el usuario y se le asigna el valor en segundo a la variable timeSelected
        if (self.timeList[row] == "Ninguna") {
            //0s
            self.timeSelected = NONE
            print(self.timeSelected)
        } else if (self.timeList[row] == "Al momento del evento") {
            // Al momento que empieza = 0s
            self.timeSelected = 0
            print(self.timeSelected)
        } else if (self.timeList[row] == "-5 minutos") {
            //-5 min = -300 sec
            self.timeSelected = -300
            print(self.timeSelected)
        } else if (self.timeList[row] == "-1 hora") {
            //-1 hr = -3600 sec
            self.timeSelected = -3600
            print(self.timeSelected)
        } else if (self.timeList[row] == "-2 hora") {
            //-2 hr = -7200 sec
            self.timeSelected = -7200
            print(self.timeSelected)
        }else if (self.timeList[row] == "-1 día") {
            //-1 día = -86400 sec
            self.timeSelected = -86400
            print(self.timeSelected)
        } else {
            //para asegurar que no se lleve un nil
            self.timeSelected = NONE
            print(self.timeSelected)
        }
        
        
    }
    
    /*
     * La función textFieldDidBeginEditing se encarga de
     * presentar el picker view al momento que se empieza
     * editar el textfield, o sea, se toca en el campo para
     * editar su valor.
     *
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.alarmPickerPopup.isHidden = false // Presenta la lista del picker view
        self.alarmTextbox.endEditing(true) // Evita que aparezca el teclado en pantalla
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Se cargan los campos para cuando se presente el pop up
        titlePopupLabel.text! = getnamePopup
        descriptionPopupLabel.text! = getdescriptionPopup
        alarmTextbox.text = timeList[0]
        
        labelSDate.text = presentingDate(dateGet: getStartDate)
        labelDDate.text = presentingDate(dateGet: getDoneDate)
    }
    
    /*
     * La función dismissPopup cierra la ventana
     * pop up que aparece para agregar el evento
     * en el calendario del dispositivo cuando se
     * presiona fuera del recuadro del mismo.
     *
     */
    @IBAction func dismissPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissXPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
     * La función btnAddingToCalendar se encarga de guardar el
     * evento actual en el calendario del dispositivo. Actualmente solo
     * almacena el título, fecha que comienza, fecha que acaba y su descripción.
     * Se debe trabajar ahora en como al crear notificaciones locales (remiders)
     * en el momento que se está guardando. Además, hay que hacerle unas modificaciones
     * (gets) a las fechas para hacerlas específicas al evento.
     *
     */
    @IBAction func btnAddingToCalendar(_ sender: Any) {
        
        let eventStore: EKEventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) { (granted, error) in
            
            if (granted) && (error == nil)
            {
                print("Permission granted: \(granted)")
                print("Error found: \(String(describing: error))")
                
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = self.getnamePopup
                
                //event.startDate = self.startDatePopup.date // Esto debe ser tomado del la data que viene del evento y
                // event.endDate = self.dueDatePopup.date    // convertilo a la manera correcta para asignarlo. Por el momento
                
                event.startDate = self.getStartDate
                event.endDate = self.getDoneDate
                
                event.notes = self.getdescriptionPopup
                print(self.timeSelected)
                print(self.NONE)
                
                if (self.timeSelected != self.NONE) {
                    //print("Entró")
                    // Creando Alarma para 60 segundos antes
                    let alarm:EKAlarm = EKAlarm(relativeOffset: TimeInterval(self.timeSelected)) // Se debe asignar según el valor escogido en el PickerView (aún por trabajar)
                    event.alarms = [alarm] // Asignando alarma al evento
                }
                
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("error: \(error)")
                }
                print("Event Successfully Saved")
                //self.dismiss(animated: true, completion: nil)
                // creando el alert
                let successAlert = UIAlertController(title: "¡Se a Guardado con Éxito!", message: "El evento se a guardado con éxito en el calendario de su dispositivo.", preferredStyle: UIAlertControllerStyle.alert)
                // Agregando el botón
                successAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {_ in
                    self.dismiss(animated: true)
                }))
                
                // Presentando el alert
                self.present(successAlert, animated: true)
                
                
            }else{
                print("Uh Oh! Error Found: \(String(describing: error))")
                // creando el alert
                let failedAlert = UIAlertController(title: "¡uh oh! ERROR", message: "Se produjo un error y no se puedo guardar el evento correctamente.", preferredStyle: UIAlertControllerStyle.alert)
                // Agregando el botón
                failedAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                
                // Presentando el alert
                self.present(failedAlert, animated: true, completion: nil)
            }
        }
    }
    
    
} // class

