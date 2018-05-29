//
//  GoogleMapViewController.swift
//  Pregunta Lobo First Prototype
//
//  Created by Mac Mini on 7/9/15.
//  Copyright (c) 2015 Cheylianie Rivera. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate, UIPopoverPresentationControllerDelegate {
    var varToPass: String = ""
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IPHONE_4_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static var IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    }
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    let UPRA_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468496,-66.741175)// crea una variable con las coordenadas de longitud y latitud
  var mapCamera = MKMapCamera()
    
    var selectedAnnotation = String()
    let mapFile = WriteToTextFile(fileNameEntered: "Map.txt")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let UPRA_LOCATION_NE: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.471332,-66.739263)
        let UPRA_LOCATION_SW: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.465982,-66.743191)
        map.mapType = MKMapType.satellite
        SegmentedControl.selectedSegmentIndex = 0

        
        if DeviceType.IPHONE_4_LESS || DeviceType.IPHONE_5 || DeviceType.IPHONE_6 || DeviceType.IPHONE_6P
        {
            //Camera 3D
            mapCamera.centerCoordinate = UPRA_LOCATION
            mapCamera.pitch = 75;
            mapCamera.altitude = 300;
            mapCamera.heading = 0;
            
            
            
        }
        else
        {
           mapCamera.centerCoordinate = UPRA_LOCATION
            mapCamera.pitch = 65;
            mapCamera.altitude = 300
            mapCamera.heading = 0;
            
            
        }
        
        self.map.camera = mapCamera;
      map.delegate = self
        
        
        //Place Coordinate
        let LatLong_ALA_CENTRAL_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468917, -66.741893)
        let LatLong_ALA_ESTE_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468653,-66.741650)
        let LatLong_ALA_NORTE_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.469486,-66.741820)
        let LatLong_ALA_OESTE_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468760,-66.742077)
        let LatLong_ALA_SUR_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468386,-66.741869)
        let LatLong_BIBLIOTECA_LOCATION: CLLocationCoordinate2D =  CLLocationCoordinate2DMake(18.470144,-66.740553)
        let LatLong_CANCHA_DE_BALONCESTO_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.466222,-66.740633)
        let LatLong_CANCHA_DE_TENIS_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.466606,-66.740614)
        let LatLong_CDATA_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468903,-66.742074)
        let LatLong_CENTRO_DE_ACOPIO_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468632,-66.741900)
        let LatLong_CENTRO_DE_ESTUDIANTES_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.469758,-66.741153)
        let LatLong_CENTRO_PREESCOLAR_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.470874,-66.742764)
        let LatLong_EDIFICIO_DE_ENFERMERIA_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468479,-66.741212)
        let LatLong_EDIFICIO_PRINCIPAL_Y_ADMINISTRACION_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.469237,-66.741178)
        let LatLong_EDUCACION_CONTINUA_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468135, -66.741222)
        let LatLong_ENTRADA_ADMINISTRATIVA_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.466029, -66.742725)
        let LatLong_ENTRADA_PRINCIPAL_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.466037, -66.739771)
        let LatLong_ENTRADA_SECUNDARIA_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.469928, -66.742644)
        let LatLong_ESTACIONAMIENTO_A1_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468882, -66.740706)
        let LatLong_ESTACIONAMIENTO_A2_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.467587, -66.741412)
        let LatLong_ESTACIONAMIENTO_B1_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.469540, -66.739977)
        let LatLong_ESTACIONAMIENTO_B2_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.470474, -66.739875)
        let LatLong_ESTACIONAMIENTO_B3_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.470358, -66.740178)
        let LatLong_ESTACIONAMIENTO_B4_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.471002, -66.740327)
        let LatLong_ESTACIONAMIENTO_C1_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.466596, -66.740217)
        let LatLong_ESTACIONAMIENTO_C2_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.466986, -66.740986)
        let LatLong_ESTACIONAMIENTO_E1_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468255, -66.740012)
        let LatLong_ESTACIONAMIENTO_E2_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.470529, -66.742143)
        let LatLong_ESTACIONAMIENTO_F1_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.469709, -66.742030)
        let LatLong_ESTACIONAMIENTO_F2_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468498, -66.742305)
        let LatLong_ESTACIONAMIENTO_F3_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468241, -66.741561)
        let LatLong_GIMNASIO_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.466494, -66.740807)
        let LatLong_PARQUE_SOFTBALL_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.467633, -66.742212)
        let LatLong_PISTA_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.466430, -66.741825)
        let LatLong_PLAZA_DE_FUNDADORES_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468950, -66.741596)
        let LatLong_SALA_DE_CINE_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.469989, -66.740815)
        let LatLong_SEGURIDAD_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.466492, -66.739822)
        let LatLong_SERVICIOS_MEDICOS_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.469732, -66.741439)
        let LatLong_TEATRO_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468889, -66.741205)
        let LatLong_TITULO_V_LOCATION: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.469025, -66.742038)
        //let LatLong_CENTRO_DE_ESTUDIANTES: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.469800, -66.741178)

        let LatLong_Anexo: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.470365, -66.742955)
        let LatLong_Centro_Aprendizaje: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.469769, -66.740552)
        let LatLong_Arecibo_Housing: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.470138, -66.744024)
        let LatLong_Cam: CLLocationCoordinate2D = CLLocationCoordinate2DMake(18.468804, -66.742010)

        
        //Places Annotation
        let ALA_CENTRAL_annotation = MKPointAnnotation()// Declare annotatio
        ALA_CENTRAL_annotation.coordinate = LatLong_ALA_CENTRAL_LOCATION
        ALA_CENTRAL_annotation.title = "Ala Central"
        map.addAnnotation(ALA_CENTRAL_annotation)// Show annotacion
        
        let ALA_ESTE_annotation = MKPointAnnotation()// Declare el annotation
        ALA_ESTE_annotation.coordinate = LatLong_ALA_ESTE_LOCATION
        ALA_ESTE_annotation.title = "Ala Este"
        map.addAnnotation(ALA_ESTE_annotation)// Show annotacion
        
        let ALA_NORTE_annotation = MKPointAnnotation()// Declare el annotation
        ALA_NORTE_annotation.coordinate = LatLong_ALA_NORTE_LOCATION
        ALA_NORTE_annotation.title = "Ala Norte"
        map.addAnnotation(ALA_NORTE_annotation)// Show annotacion
        
        let ALA_OESTE_annotation = MKPointAnnotation()// Declare el annotation
        ALA_OESTE_annotation.coordinate = LatLong_ALA_OESTE_LOCATION
        ALA_OESTE_annotation.title = "Ala Oeste"
        map.addAnnotation(ALA_OESTE_annotation)// Show annotacion
        
        let ALA_SUR_annotation = MKPointAnnotation()// Declare el annotation
        ALA_SUR_annotation.coordinate = LatLong_ALA_SUR_LOCATION
        ALA_SUR_annotation.title = "Ala Sur"
        map.addAnnotation(ALA_SUR_annotation)// Show annotacion
        
        let BIBLIOTECA_annotation = MKPointAnnotation()// Declare el annotation
        BIBLIOTECA_annotation.coordinate = LatLong_BIBLIOTECA_LOCATION
        BIBLIOTECA_annotation.title = "Biblioteca"
        map.addAnnotation(BIBLIOTECA_annotation)// Show annotacion
        
        let CANCHA_DE_BALONCESTO_annotation = MKPointAnnotation()// Declare el annotation
        CANCHA_DE_BALONCESTO_annotation.coordinate = LatLong_CANCHA_DE_BALONCESTO_LOCATION
        CANCHA_DE_BALONCESTO_annotation.title = "Cancha de Baloncesto"
        map.addAnnotation(CANCHA_DE_BALONCESTO_annotation)// Show annotacion
        
        let CANCHA_DE_TENIS_annotation = MKPointAnnotation()// Declare el annotation
        CANCHA_DE_TENIS_annotation.coordinate = LatLong_CANCHA_DE_TENIS_LOCATION
        CANCHA_DE_TENIS_annotation.title = "Cancha de Tenis"
        map.addAnnotation(CANCHA_DE_TENIS_annotation)
        
        let CDATA_annotation = MKPointAnnotation()// Declare el annotation
        CDATA_annotation.coordinate = LatLong_CDATA_LOCATION
        CDATA_annotation.title = "CDATA"
        map.addAnnotation(CDATA_annotation)
        
        let CENTRO_DE_ACOPIO_annotation = MKPointAnnotation()// Declare el annotation
        CENTRO_DE_ACOPIO_annotation.coordinate = LatLong_CENTRO_DE_ACOPIO_LOCATION
        CENTRO_DE_ACOPIO_annotation.title = "Centro de Acopio"
        map.addAnnotation(CENTRO_DE_ACOPIO_annotation)
        
        let CENTRO_DE_ESTUDIANTES_annotation = MKPointAnnotation()// Declare el annotation
        CENTRO_DE_ESTUDIANTES_annotation.coordinate = LatLong_CENTRO_DE_ESTUDIANTES_LOCATION
        CENTRO_DE_ESTUDIANTES_annotation.title = "Centro de Estudiante"
        map.addAnnotation(CENTRO_DE_ESTUDIANTES_annotation)
        
        let CENTRO_PREESCOLAR_annotation = MKPointAnnotation()// Declare el annotation
        CENTRO_PREESCOLAR_annotation.coordinate = LatLong_CENTRO_PREESCOLAR_LOCATION
        CENTRO_PREESCOLAR_annotation.title = "Centro Pre-Escolar"
        map.addAnnotation(CENTRO_PREESCOLAR_annotation)
        
        let EDIFICIO_DE_ENFERMERIA_annotation = MKPointAnnotation()// Declare el annotation
        EDIFICIO_DE_ENFERMERIA_annotation.coordinate = LatLong_EDIFICIO_DE_ENFERMERIA_LOCATION
        EDIFICIO_DE_ENFERMERIA_annotation.title = "Edificio de Enfermería"
        map.addAnnotation(EDIFICIO_DE_ENFERMERIA_annotation)
        
        let EDIFICIO_PRINCIPAL_Y_ADMINISTRACION_annotation = MKPointAnnotation()// Declare el annotation
        EDIFICIO_PRINCIPAL_Y_ADMINISTRACION_annotation.coordinate = LatLong_EDIFICIO_PRINCIPAL_Y_ADMINISTRACION_LOCATION
        EDIFICIO_PRINCIPAL_Y_ADMINISTRACION_annotation.title = "Edificio Principal"
        map.addAnnotation(EDIFICIO_PRINCIPAL_Y_ADMINISTRACION_annotation)
        
        let EDUCACION_CONTINUA_annotation = MKPointAnnotation()// Declare el annotation
        EDUCACION_CONTINUA_annotation.coordinate = LatLong_EDUCACION_CONTINUA_LOCATION
        EDUCACION_CONTINUA_annotation.title = "Educación Continua"
        map.addAnnotation(EDUCACION_CONTINUA_annotation)
        
        let ENTRADA_ADMINISTRATIVA_annotation = MKPointAnnotation()// Declare el annotation
        ENTRADA_ADMINISTRATIVA_annotation.coordinate = LatLong_ENTRADA_ADMINISTRATIVA_LOCATION
        ENTRADA_ADMINISTRATIVA_annotation.title = "Entrada Administrativa"
        map.addAnnotation(ENTRADA_ADMINISTRATIVA_annotation)
        
        let ENTRADA_PRINCIPAL_annotation = MKPointAnnotation()// Declare el annotation
        ENTRADA_PRINCIPAL_annotation.coordinate = LatLong_ENTRADA_PRINCIPAL_LOCATION
        ENTRADA_PRINCIPAL_annotation.title = "Entrada Principal"
        map.addAnnotation(ENTRADA_PRINCIPAL_annotation)
        
        let ENTRADA_SECUNDARIA_annotation = MKPointAnnotation()// Declare el annotation
        ENTRADA_SECUNDARIA_annotation.coordinate = LatLong_ENTRADA_SECUNDARIA_LOCATION
        ENTRADA_SECUNDARIA_annotation.title = "Entrada Secundaria"
        map.addAnnotation(ENTRADA_SECUNDARIA_annotation)
        
        let ESTACIONAMIENTO_A1_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_A1_annotation.coordinate = LatLong_ESTACIONAMIENTO_A1_LOCATION
        ESTACIONAMIENTO_A1_annotation.title = "Estacionamiento-A1"
        map.addAnnotation(ESTACIONAMIENTO_A1_annotation)
        
        let ESTACIONAMIENTO_A2_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_A2_annotation.coordinate = LatLong_ESTACIONAMIENTO_A2_LOCATION
        ESTACIONAMIENTO_A2_annotation.title = "Estacionamiento-A2"
        map.addAnnotation(ESTACIONAMIENTO_A2_annotation)
        
        let ESTACIONAMIENTO_B1_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_B1_annotation.coordinate = LatLong_ESTACIONAMIENTO_B1_LOCATION
        ESTACIONAMIENTO_B1_annotation.title = "Estacionamiento-B1"
        map.addAnnotation(ESTACIONAMIENTO_B1_annotation)
        
        let ESTACIONAMIENTO_B2_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_B2_annotation.coordinate = LatLong_ESTACIONAMIENTO_B2_LOCATION
        ESTACIONAMIENTO_B2_annotation.title = "Estacionamiento-B2"
        map.addAnnotation(ESTACIONAMIENTO_B2_annotation)
        
        let ESTACIONAMIENTO_B3_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_B3_annotation.coordinate = LatLong_ESTACIONAMIENTO_B3_LOCATION
        ESTACIONAMIENTO_B3_annotation.title = "Estacionamiento-B3"
        map.addAnnotation(ESTACIONAMIENTO_B3_annotation)
        
        let ESTACIONAMIENTO_B4_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_B4_annotation.coordinate = LatLong_ESTACIONAMIENTO_B4_LOCATION
        ESTACIONAMIENTO_B4_annotation.title = "Estacionamiento-B4"
        map.addAnnotation(ESTACIONAMIENTO_B4_annotation)
        
        let ESTACIONAMIENTO_C1_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_C1_annotation.coordinate = LatLong_ESTACIONAMIENTO_C1_LOCATION
        ESTACIONAMIENTO_C1_annotation.title = "Estacionamiento-C1"
        map.addAnnotation(ESTACIONAMIENTO_C1_annotation)
        
        let ESTACIONAMIENTO_C2_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_C2_annotation.coordinate = LatLong_ESTACIONAMIENTO_C2_LOCATION
        ESTACIONAMIENTO_C2_annotation.title = "Estacionamiento-C2"
        map.addAnnotation(ESTACIONAMIENTO_C2_annotation)
        
        let ESTACIONAMIENTO_E1_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_E1_annotation.coordinate = LatLong_ESTACIONAMIENTO_E1_LOCATION
        ESTACIONAMIENTO_E1_annotation.title = "Estacionamiento-E1"
        map.addAnnotation(ESTACIONAMIENTO_E1_annotation)
        
        let ESTACIONAMIENTO_E2_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_E2_annotation.coordinate = LatLong_ESTACIONAMIENTO_E2_LOCATION
        ESTACIONAMIENTO_E2_annotation.title = "Estacionamiento-E2"
        map.addAnnotation(ESTACIONAMIENTO_E2_annotation)
        
        let ESTACIONAMIENTO_F1_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_F1_annotation.coordinate = LatLong_ESTACIONAMIENTO_F1_LOCATION
        ESTACIONAMIENTO_F1_annotation.title = "Estacionamiento-F1"
        map.addAnnotation(ESTACIONAMIENTO_F1_annotation)
        
        let ESTACIONAMIENTO_F2_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_F2_annotation.coordinate = LatLong_ESTACIONAMIENTO_F2_LOCATION
        ESTACIONAMIENTO_F2_annotation.title = "Estacionamiento-F2"
        map.addAnnotation(ESTACIONAMIENTO_F2_annotation)
        
        let ESTACIONAMIENTO_F3_annotation = MKPointAnnotation()// Declare el annotation
        ESTACIONAMIENTO_F3_annotation.coordinate = LatLong_ESTACIONAMIENTO_F3_LOCATION
        ESTACIONAMIENTO_F3_annotation.title = "Estacionamiento-F3"
        map.addAnnotation(ESTACIONAMIENTO_F3_annotation)
        
        let GIMNASIO_annotation = MKPointAnnotation()// Declare el annotation
        GIMNASIO_annotation.coordinate = LatLong_GIMNASIO_LOCATION
        GIMNASIO_annotation.title = "Gimnasio"
        map.addAnnotation(GIMNASIO_annotation)
        
        let PARQUE_SOFTBALL_annotation = MKPointAnnotation()// Declare el annotation
        PARQUE_SOFTBALL_annotation.coordinate = LatLong_PARQUE_SOFTBALL_LOCATION
        PARQUE_SOFTBALL_annotation.title = "Parque de Softball"
        map.addAnnotation(PARQUE_SOFTBALL_annotation)
        
        let PISTA_annotation = MKPointAnnotation()// Declare el annotation
        PISTA_annotation.coordinate = LatLong_PISTA_LOCATION
        PISTA_annotation.title = "Pista"
        map.addAnnotation(PISTA_annotation)
        
        let PLAZA_DE_FUNDADORES_annotation = MKPointAnnotation()// Declare el annotation
        PLAZA_DE_FUNDADORES_annotation.coordinate = LatLong_PLAZA_DE_FUNDADORES_LOCATION
        PLAZA_DE_FUNDADORES_annotation.title = "Plaza de Fundadores"
        map.addAnnotation(PLAZA_DE_FUNDADORES_annotation)
        
        let SALA_DE_CINE_annotation = MKPointAnnotation()// Declare el annotation
        SALA_DE_CINE_annotation.coordinate = LatLong_SALA_DE_CINE_LOCATION
        SALA_DE_CINE_annotation.title = "Sala de Cine"
        map.addAnnotation(SALA_DE_CINE_annotation)
        
        let SEGURIDAD_annotation = MKPointAnnotation()// Declare el annotation
        SEGURIDAD_annotation.coordinate = LatLong_SEGURIDAD_LOCATION
        SEGURIDAD_annotation.title = "Seguridad"
        map.addAnnotation(SEGURIDAD_annotation)
        
        let SERVICIOS_MEDICOS_annotation = MKPointAnnotation()// Declare el annotation
        SERVICIOS_MEDICOS_annotation.coordinate = LatLong_SERVICIOS_MEDICOS_LOCATION
        SERVICIOS_MEDICOS_annotation.title = "Servicios Médicos"
        map.addAnnotation(SERVICIOS_MEDICOS_annotation)
        
        let TEATRO_annotation = MKPointAnnotation()// Declare el annotation
        TEATRO_annotation.coordinate = LatLong_TEATRO_LOCATION
        TEATRO_annotation.title = "Teatro"
        map.addAnnotation(TEATRO_annotation)
        
        let TITULO_V_annotation = MKPointAnnotation()// Declare el annotation
        TITULO_V_annotation.coordinate = LatLong_TITULO_V_LOCATION
        TITULO_V_annotation.title = "Título V"
        map.addAnnotation(TITULO_V_annotation)
        
        let UPRA_NE_annotation = MKPointAnnotation()// Declare el annotation
        UPRA_NE_annotation.coordinate = UPRA_LOCATION_NE
        UPRA_NE_annotation.title = "UPRA NE"
        map.addAnnotation(UPRA_NE_annotation)
        
        let UPRA_SW_annotation = MKPointAnnotation()// Declare el annotation
        UPRA_SW_annotation.coordinate = UPRA_LOCATION_SW
        UPRA_SW_annotation.title = "UPRA SW"
        map.addAnnotation(UPRA_SW_annotation)
        
        
        let ANEXO_annotation = MKPointAnnotation()// Declare el annotation
        ANEXO_annotation.coordinate = LatLong_Anexo
        ANEXO_annotation.title = "Anexos"
        map.addAnnotation(ANEXO_annotation)
        
        let CENTRO_APRENDIZAJE_annotation = MKPointAnnotation()
        CENTRO_APRENDIZAJE_annotation.coordinate = LatLong_Centro_Aprendizaje
        CENTRO_APRENDIZAJE_annotation.title = "Centro de Aprendizaje"
        map.addAnnotation(CENTRO_APRENDIZAJE_annotation)
        
        
        let CAM_annotation = MKPointAnnotation()// Declare annotation
        CAM_annotation.coordinate = LatLong_Cam
        CAM_annotation.title = "CAM"
        map.addAnnotation(CAM_annotation)// Show annotacion

    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKPointAnnotation {
            var customAnnotationView : MKAnnotationView!
            if annotation.title! == "Estacionamiento-E1" || annotation.title! == "Estacionamiento-E2" || annotation.title! == "Estacionamiento-B1" || annotation.title! == "Estacionamiento-B2" || annotation.title! == "Estacionamiento-B4" || annotation.title! == "Estacionamiento-C1"
            {
                customAnnotationView = MKAnnotationView(annotation: annotation , reuseIdentifier: "myPin")
                let Image = UIImage(named:"blue_car_icon_2.png")
                let size = CGSize(width: 25, height: 15)
                UIGraphicsBeginImageContext(size)
                Image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                customAnnotationView.image = resizedImage
                customAnnotationView.canShowCallout = true
                 return customAnnotationView
            }
            if annotation.title! == "Estacionamiento-B3" || annotation.title! == "Estacionamiento-F1" || annotation.title! == "Estacionamiento-A1" || annotation.title! == "Estacionamiento-F2" || annotation.title! == "Estacionamiento-F3" || annotation.title! == "Estacionamiento-A2" || annotation.title! == "Estacionamiento-C2"
            {
                customAnnotationView = MKAnnotationView(annotation: annotation , reuseIdentifier: "myPin")
                let Image = UIImage(named:"golden_car_icon.png")
                let size = CGSize(width: 25, height: 15)
                UIGraphicsBeginImageContext(size)
                Image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                customAnnotationView.image = resizedImage
                customAnnotationView.canShowCallout = true
                return customAnnotationView
            }
            if annotation.title! == "Servicios Médicos"
            {
                customAnnotationView = MKAnnotationView(annotation: annotation , reuseIdentifier: "myPin")
                let Image = UIImage(named:"first_aid_icon.png")
                let size = CGSize(width: 20, height: 15)
                UIGraphicsBeginImageContext(size)
                Image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                customAnnotationView.image = resizedImage
                customAnnotationView.canShowCallout = true
                customAnnotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure) as UIView
                return customAnnotationView
            }
            if annotation.title! == "Seguridad"
            {
                customAnnotationView = MKAnnotationView(annotation: annotation , reuseIdentifier: "myPin")
                let Image = UIImage(named:"security_icon.png")
                let size = CGSize(width: 20, height: 15)
                UIGraphicsBeginImageContext(size)
                Image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                customAnnotationView.image = resizedImage
                customAnnotationView.canShowCallout = true
                customAnnotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure) as UIView
                return customAnnotationView
                
            }
            
            if annotation.title! == "Entrada Principal"
            {
                customAnnotationView = MKAnnotationView(annotation: annotation , reuseIdentifier: "myPin")
                let Image = UIImage(named:"entrance_icon_white.png")
                let size = CGSize(width: 20, height: 20)
                UIGraphicsBeginImageContext(size)
                Image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                customAnnotationView.image = resizedImage
                customAnnotationView.canShowCallout = true
                customAnnotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure) as UIView
                return customAnnotationView
            }
                
            if annotation.title! == "Entrada Administrativa"
            {
                customAnnotationView = MKAnnotationView(annotation: annotation , reuseIdentifier: "myPin")
                let Image = UIImage(named:"entrance_icon_white.png")
                let size = CGSize(width: 20, height: 20)
                UIGraphicsBeginImageContext(size)
                Image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                customAnnotationView.image = resizedImage
                customAnnotationView.canShowCallout = true
                customAnnotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure) as UIView
                return customAnnotationView
            }
                
            if annotation.title! == "Entrada Secundaria"
            {
                customAnnotationView = MKAnnotationView(annotation: annotation , reuseIdentifier: "myPin")
                let Image = UIImage(named:"rotated_entrance_icon_white.png")
                let size = CGSize(width: 20, height: 20)
                UIGraphicsBeginImageContext(size)
                Image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                customAnnotationView.image = resizedImage
                customAnnotationView.canShowCallout = true
                customAnnotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure) as UIView
                return customAnnotationView
            }
                
            if annotation.title! == "CAM"
            {
                customAnnotationView = MKAnnotationView(annotation: annotation , reuseIdentifier: "myPin")
                let Image = UIImage(named:"logo_app.png")
                let size = CGSize(width: 25, height: 25)
                UIGraphicsBeginImageContext(size)
                Image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                customAnnotationView.image = resizedImage
                customAnnotationView.canShowCallout = true
                customAnnotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure) as UIView
                return customAnnotationView
            }

   
            else
            {
    
                var pinAnnotationView = MKAnnotationView()
                
                if #available(iOS 11.0, *) {
                    pinAnnotationView = MKMarkerAnnotationView()
                } else {
                    pinAnnotationView = MKAnnotationView()
                }
                
                //pinAnnotationView.pinTintColor = .red
                pinAnnotationView.isDraggable = false
                pinAnnotationView.canShowCallout = true
                //pinAnnotationView.animatesDrop = false
                pinAnnotationView.isHighlighted = false
                pinAnnotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure) as UIView
                
                return pinAnnotationView
            }
        }
        
        return nil
    }
  
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
        if control == view.rightCalloutAccessoryView{
            let annotationName = view.annotation
            selectedAnnotation = ((annotationName?.title)!)!
            
            
            return performSegue(withIdentifier: "mapToInfoSegue", sender: self)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapToInfoSegue" {
            let destinationVC = segue.destination as! MapInfoViewController
            var myTable = TablaMapa()
            
            
            let annotationTitle = String(selectedAnnotation)
            let mapInfoModel = MapInfoModel()
            //let myFile = WriteToTextFile(fileName: "adsfdsafdsafa", header: "Mapa.txt")
            
            myTable = mapInfoModel.getInfoFromDatabase(annotationTitle!)
            destinationVC.placeInfo = myTable.info
            destinationVC.floor = myTable.floor1
            destinationVC.floor2 = myTable.floor2
            destinationVC.navigationTitle = annotationTitle!
            destinationVC.placeFoto = myTable.image1
            destinationVC.placeFoto2 = myTable.image2
            destinationVC.placeFoto3 = myTable.image3
            mapFile.writeToFile("***************Feedback De Mapa****************", stringToFile: annotationTitle! + "\n")
        }
        
        if segue.identifier == "popoverSegue" {
            let popoverViewController = segue.destination
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
    }
    
        
    @IBAction func SegmentedControl(_ sender: UISegmentedControl) {
        
            if(SegmentedControl.titleForSegment(at: sender.selectedSegmentIndex) == "Satellite"){
                map.mapType = MKMapType.satellite
            }
            
            if(SegmentedControl.titleForSegment(at: sender.selectedSegmentIndex) == "Satellite Flyover"){
                if #available(iOS 9.0, *) {
                    map.mapType = MKMapType.satelliteFlyover
                } else {
                    let alert = UIAlertController(title: "Alert", message: "Type for iOS9 or above", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    SegmentedControl.selectedSegmentIndex = 0
                    map.mapType=MKMapType.satellite                  // Fallback on earlier versions

                }
            }
        
        if(SegmentedControl.titleForSegment(at: sender.selectedSegmentIndex) == "Hybrid Flyover"){
            if #available(iOS 9.0, *) {
                map.mapType = MKMapType.hybridFlyover
            } else {
                let alert = UIAlertController(title: "Alert", message: "Type for iOS9 or above", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                SegmentedControl.selectedSegmentIndex = 0
                map.mapType=MKMapType.hybrid                 // Fallback on earlier versions

            }
        }
        
    }
  
    // Vuelve a la coordenadas de inicio al cambiar los tabs
    override func viewWillAppear(_ animated: Bool) {
   
        
        if DeviceType.IPHONE_4_LESS || DeviceType.IPHONE_5 || DeviceType.IPHONE_6 || DeviceType.IPHONE_6P
        {
            //Camera 3D
            map.mapType = MKMapType.satellite
            SegmentedControl.selectedSegmentIndex = 0
            mapCamera.centerCoordinate = UPRA_LOCATION
            mapCamera.pitch = 75;
            mapCamera.altitude = 300;
            mapCamera.heading = 0;
          self.map.camera = mapCamera;
            
            
            
        }
        else
        {
            map.mapType = MKMapType.satellite
            SegmentedControl.selectedSegmentIndex = 0
            mapCamera.centerCoordinate = UPRA_LOCATION
            mapCamera.pitch = 65;
            mapCamera.altitude = 430;
            mapCamera.heading = 0;
            self.map.camera = mapCamera;
            
            
            
            
        }

    }
    
  
  func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    
    
}



