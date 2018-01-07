//
//  AppDelegate.swift
//  Pregunta Lobo First Prototype
//
//  Created by Mac Mini on 7/3/15.
//  Copyright (c) 2015 Cheylianie Rivera. All rights reserved.
//

//import UIKit
//import CoreData
//import UserNotifications
//import FirebaseInstanceID
//import Firebase
//import FirebaseMessaging
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//
//    var util = Utility()
//    var model = QuestionModel()
//    var categoriesModel = CategoriesModel()
//    var mapModel = MapInfoModel()
//
//    //Archivos
//    var exportFile = WriteToTextFile(fileNameEntered: "Archivo_A_Exportar.txt")
//    var preguntasEncontradasFile = WriteToTextFile(fileNameEntered: "Preguntas_Encontradas.txt")
//    var preguntasNoEncontradaFile = WriteToTextFile(fileNameEntered: "Preguntas_No_Encontradas.txt")
//    var asociacionesFile = WriteToTextFile(fileNameEntered: "Asociaciones.txt")
//    var userFeedbackFile = WriteToTextFile(fileNameEntered: "User_Feedback.txt")
//    var starRatingFile = WriteToTextFile(fileNameEntered: "Star_Rating.txt")
//    var mapFile = WriteToTextFile(fileNameEntered: "Map.txt")
//
//    let password = ",48$jB^,S%3,14yQ"
//    let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
//
//    // -------------------------------------------------------------------------------------------------
//
//    // ERC
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//
//        // Override point for customization after application launch.
//
//        //Enviar mensaje de bienvenida si es la primera vez que se corre.
//        checkIfAppRunsForTheFirstTime()
//
//
//
//        //Copiar base de datos de preguntas.
//        util.copyFile("testdb.db")
//        model.getInstance()
//
//        //Copiar base de datos de asociaciones.
//        util.copyFile("asociacionesdb.db")
//        categoriesModel.getInstance()
//
//        util.copyFile("Map.db")
//        mapModel.getInstance()
//
//
//
//        // Verifica el device y presenta el storyboard correspondiente
//
//        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
//            var mainView: UIStoryboard!
//            mainView = UIStoryboard(name: "Main", bundle: nil)
//
//            let viewController: UIViewController = mainView.instantiateViewController(withIdentifier: "iPadStoryboard") as UIViewController
//
//            self.window!.rootViewController = viewController
//
//        }
//
//        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) {
//            var mainView: UIStoryboard!
//            mainView = UIStoryboard(name: "iPod", bundle: nil)
//
//            let viewController: UIViewController = mainView.instantiateViewController(withIdentifier: "iPodStoryboard") as UIViewController
//
//            self.window!.rootViewController = viewController
//
//        }
//
//        //  ERC
//        // [START register_for_notifications]
//
//        if #available(iOS 10.0, *) {
//            let authOptions : UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_,_ in })
//
//            // For iOS 10 display notification (sent via APNS)
//            UNUserNotificationCenter.current().delegate = self
//            // For iOS 10 data message (sent via FCM)
//            FIRMessaging.messaging().remoteMessageDelegate = self
//
//        } else {
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//            application.registerUserNotificationSettings(settings)
//        }
//
//        application.registerForRemoteNotifications()
//
//        // [END register_for_notifications]
//        FIRApp.configure()
//
//        // Add observer for InstanceID token refresh callback.
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(self.tokenRefreshNotification),
//                                               name: .firInstanceIDTokenRefresh,
//                                               object: nil)
//        let launchBefore = UserDefaults.standard.bool(forKey: "launchBefore")
//        if launchBefore {
//            print("NO PRIMERA CORRIDA")
//        } else {
//            print("PRIMERA CORRIDA")
//            UserDefaults.standard.set(true, forKey: "launchBefore")
//            FIRMessaging.messaging().subscribe(toTopic: "/topics/CAM")
//        }
//
//        return true
//    }
//
//
//    //  ERC
//    // [START receive_message]
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        // If you are receiving a notification message while your app is in the background,
//        // this callback will not be fired till the user taps on the notification launching the application.
//        // TODO: Handle data of notification
//        // Print message ID.
//        print("")
//        print("Message ID: \(userInfo["gcm.message_id"]!)")
//
//        // Print full message.
//        print("%@", userInfo)
//    }
//    // [END receive_message]
//
//    //  ERC
//    // [START refresh_token]
//    func tokenRefreshNotification(notification: NSNotification) {
//
//        if let refreshedToken = FIRInstanceID.instanceID().token() {
//            print("InstanceID token: \(refreshedToken)")
//        }
//
//        // Volvemos a conectar con FCM porque se pudo haber perdido comunicacion cuando se trato de obtener el token
//        connectToFcm()
//
//    }
//    // [END refresh_token]
//
//
//    //  ERC
//    // [START connect_to_fcm]
//    func connectToFcm() {
//        FIRMessaging.messaging().connect { (error) in
//            if (error != nil) {
//                print("Unable to connect with FCM. \(error)")
//            } else {
//                print("Connected to FCM.")
//            }
//        }
//    }
//    // [END connect_to_fcm]
//
//    func applicationWillTerminate(_ application: UIApplication) {
//        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//        // Saves changes in the application's managed object context before the application terminates.
//        self.saveContext()
//    }
//
//
//
//    public func application (_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//
//
//        // Configura el app ya sea producción o sandbox
//        //FIRInstanceID.instanceID().setAPNSToken(deviceToken as Data, type: FIRInstanceIDAPNSTokenType.sandbox)
//        FIRInstanceID.instanceID().setAPNSToken(deviceToken as Data, type: FIRInstanceIDAPNSTokenType.prod)
//
//
//    }
//
//
//
//    //  ERC
//    func applicationDidBecomeActive(_ application: UIApplication) {
//
//        // Resets the app icon badge to 0
//        application.applicationIconBadgeNumber = 0
//
//        connectToFcm()
//
//
//
//        //SocketIOManager.sharedInstance.establishConnection()
//        checkFileWhenAppStarts()
//
//    }
//
//    //  ERC
//    // [START disconnect_from_fcm]
//    func applicationDidEnterBackground(_ application: UIApplication) {
//
//        checkFileWhenAppCloses()
//
//        sleep(1)
//        SocketIOManager.sharedInstance.closeConnection()
//
//
//        FIRMessaging.messaging().disconnect()
//        print("Disconnected from FCM.")
//    }
//    // [END disconnect_from_fcm]
//
//
//    // MARK: - Core Data stack
//
//    lazy var persistentContainer: NSPersistentContainer = {
//        /*
//         The persistent container for the application. This implementation
//         creates and returns a container, having loaded the store for the
//         application to it. This property is optional since there are legitimate
//         error conditions that could cause the creation of the store to fail.
//         */
//        let container = NSPersistentContainer(name: "Pregunta Lobo")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                /*
//                 Typical reasons for an error here include:
//                 * The parent directory does not exist, cannot be created, or disallows writing.
//                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                 * The device is out of space.
//                 * The store could not be migrated to the current model version.
//                 Check the error message to determine what the actual problem was.
//                 */
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//
//    // -------------------------------------------------------------------------------------------------
//    //Enviar mensaje de bienvenida si es la primera vez que se corre.
//    func checkIfAppRunsForTheFirstTime() {
//
//        let alert = UIAlertView()
//        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
//
//        if launchedBefore  {
//            print("Not first launch.")
//        }
//        else {
//            print("First launch.")
//            alert.title = "Pregunta Lobo"
//            alert.message = "Bienvenido a Pregunta Lobo."
//            alert.delegate = nil
//            alert.addButton(withTitle: "Ok")
//            alert.show()
//            UserDefaults.standard.set(true, forKey: "launchedBefore")
//
//            //Suscribe a todos los usuarios a notificaciones del CAM
//            FIRMessaging.messaging().subscribe(toTopic: "/topics/CAM")
//            print("subscribed to CAM Topic :)")
//        }
//
//    }
//
//    func checkFileWhenAppStarts() {
//        if !exportFile.fileIsEmpty() {
//            SocketIOManager.sharedInstance.sendMessage(message: exportFile.readFile())
//            exportFile.ereaseFile()
//        }
//    }
//
//    func checkFileWhenAppCloses() {
//
//        if exportFile.fileIsEmpty() {
//
//            exportFile.writeToFile(password + "\n" + UUIDValue, stringToFile: "")
//
//            //Escribir toda la data al archivo info.txt
//            preguntasEncontradasFile.copyFile("Archivo_A_Exportar.txt")
//            preguntasNoEncontradaFile.copyFile("Archivo_A_Exportar.txt")
//            asociacionesFile.copyFile("Archivo_A_Exportar.txt")
//            starRatingFile.copyFile("Archivo_A_Exportar.txt")
//            userFeedbackFile.copyFile("Archivo_A_Exportar.txt")
//            mapFile.copyFile("Archivo_A_Exportar.txt")
//
//            //Borrar los archivos por categorias.
//            preguntasEncontradasFile.ereaseFile()
//            preguntasNoEncontradaFile.ereaseFile()
//            asociacionesFile.ereaseFile()
//            starRatingFile.ereaseFile()
//            userFeedbackFile.ereaseFile()
//            mapFile.ereaseFile()
//
//            //SocketIOManager.sharedInstance.sendMessage(exportFile.readFile())
//            exportFile.ereaseFile()
//        }
//        else if !exportFile.fileIsEmpty() {
//            //Escribir toda la data al archivo info.txt
//            preguntasEncontradasFile.copyFile("Archivo_A_Exportar.txt")
//            preguntasNoEncontradaFile.copyFile("Archivo_A_Exportar.txt")
//            asociacionesFile.copyFile("Archivo_A_Exportar.txt")
//            starRatingFile.copyFile("Archivo_A_Exportar.txt")
//            userFeedbackFile.copyFile("Archivo_A_Exportar.txt")
//            mapFile.copyFile("Archivo_A_Exportar.txt")
//
//            //Borrar los archivos por categorias.
//            preguntasEncontradasFile.ereaseFile()
//            preguntasNoEncontradaFile.ereaseFile()
//            asociacionesFile.ereaseFile()
//            starRatingFile.ereaseFile()
//            userFeedbackFile.ereaseFile()
//            mapFile.ereaseFile()
//
//            //SocketIOManager.sharedInstance.sendMessage(exportFile.readFile())
//            exportFile.ereaseFile()
//        }
//    }
//
//
//
//
//    func applicationWillResignActive(_ application: UIApplication) {
//        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//        checkFileWhenAppCloses()
//        sleep(1)
//        SocketIOManager.sharedInstance.closeConnection()
//    }
//
//
//
//    func applicationWillEnterForeground(_ application: UIApplication) {
//        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    }
//
//
//
//}
//
////  ERC
//// [START ios_10_message_handling]
//@available(iOS 10, *)
//extension AppDelegate : UNUserNotificationCenterDelegate {
//    // Receive displayed notifications for iOS 10 devices.
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let userInfo = notification.request.content.userInfo
//
//        // Print message ID.
//        print(userInfo)
//
//        // Manages to also receive push notifications on the foreground ERC
//        completionHandler([UNNotificationPresentationOptions.alert,
//                          UNNotificationPresentationOptions.sound,
//                          UNNotificationPresentationOptions.badge])
//
//
//        print("Message ID: \(userInfo["gcm.message_id"]!)")
//        // Print full message.
//        print("%@", userInfo)
//    }
//
//}
//extension AppDelegate : FIRMessagingDelegate {
//    // Receive data message on iOS 10 devices.
//    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
//        print("%@", remoteMessage.appData)
//    }
//}
//// [END ios_10_message_handling]

import UIKit
import UserNotifications

import Firebase
import CoreData
import FirebaseInstanceID
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    
    var util = Utility()
    var model = QuestionModel()
    var categoriesModel = CategoriesModel()
    var mapModel = MapInfoModel()
    
    //Archivos
        var exportFile = WriteToTextFile(fileNameEntered: "Archivo_A_Exportar.txt")
        var preguntasEncontradasFile = WriteToTextFile(fileNameEntered: "Preguntas_Encontradas.txt")
        var preguntasNoEncontradaFile = WriteToTextFile(fileNameEntered: "Preguntas_No_Encontradas.txt")
        var asociacionesFile = WriteToTextFile(fileNameEntered: "Asociaciones.txt")
        var userFeedbackFile = WriteToTextFile(fileNameEntered: "User_Feedback.txt")
        var starRatingFile = WriteToTextFile(fileNameEntered: "Star_Rating.txt")
        var mapFile = WriteToTextFile(fileNameEntered: "Map.txt")
    
        let password = ",48$jB^,S%3,14yQ"
        let UUIDValue = UIDevice.current.identifierForVendor!.uuidString
    
    // -------------------------------------------------------------------------------------------------
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        //Enviar mensaje de bienvenida si es la primera vez que se corre.
        checkIfAppRunsForTheFirstTime()
        
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        //Copiar base de datos de preguntas.
        util.copyFile("testdb.db")
        model.getInstance()

        //Copiar base de datos de asociaciones.
        util.copyFile("asociacionesdb.db")
        categoriesModel.getInstance()

        util.copyFile("Map.db")
        mapModel.getInstance()



        // Verifica el device y presenta el storyboard correspondiente

        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            var mainView: UIStoryboard!
            mainView = UIStoryboard(name: "Main", bundle: nil)

            let viewController: UIViewController = mainView.instantiateViewController(withIdentifier: "iPadStoryboard") as UIViewController

            self.window!.rootViewController = viewController

        }

        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone) {
            var mainView: UIStoryboard!
            mainView = UIStoryboard(name: "iPod", bundle: nil)

            let viewController: UIViewController = mainView.instantiateViewController(withIdentifier: "iPodStoryboard") as UIViewController

            self.window!.rootViewController = viewController

        }

        // Verifica si es la primera vez que se corre el app en el dispositivo.
        // [START verify_run_time]
        let launchBefore = UserDefaults.standard.bool(forKey: "launchBefore")
        if launchBefore {
            print("NO PRIMERA CORRIDA")
        } else {
            print("PRIMERA CORRIDA")
            UserDefaults.standard.set(true, forKey: "launchBefore")
            Messaging.messaging().subscribe(toTopic: "/topics/CAM")
        }
        // [END register_for_notifications]
        
        application.applicationIconBadgeNumber = 0
        
        return true
    }
    
    //Enviar mensaje de bienvenida si es la primera vez que se corre.
    func checkIfAppRunsForTheFirstTime() {

        let alert = UIAlertView()
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")

        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch.")
            alert.title = "Pregunta Lobo"
            alert.message = "Bienvenido a Pregunta Lobo."
            alert.delegate = nil
            alert.addButton(withTitle: "Ok")
            alert.show()
            UserDefaults.standard.set(true, forKey: "launchedBefore")

            let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
            if isRegisteredForRemoteNotifications {
                // User is registered for notification
                //Suscribe a todos los usuarios a notificaciones del CAM
                Messaging.messaging().subscribe(toTopic: "/topics/CAM")
                print("subscribed to CAM Topic :)")
            }
            
        }

    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    //  ERC
    func applicationDidBecomeActive(_ application: UIApplication) {

        // Resets the app icon badge to 0
        application.applicationIconBadgeNumber = 0



        SocketIOManager.sharedInstance.establishConnection()
        checkFileWhenAppStarts()

    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
        
        
    }
    
    //  ERC
  
    func applicationDidEnterBackground(_ application: UIApplication) {

        checkFileWhenAppCloses()

        sleep(1)
        SocketIOManager.sharedInstance.closeConnection()

    }


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Pregunta Lobo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
        func checkFileWhenAppStarts() {
            if !exportFile.fileIsEmpty() {
                SocketIOManager.sharedInstance.sendMessage(message: exportFile.readFile())
                exportFile.ereaseFile()
            }
        }
    
        func checkFileWhenAppCloses() {
    
            if exportFile.fileIsEmpty() {
    
                exportFile.writeToFile(password + "\n" + UUIDValue, stringToFile: "")
    
                //Escribir toda la data al archivo info.txt
                preguntasEncontradasFile.copyFile("Archivo_A_Exportar.txt")
                preguntasNoEncontradaFile.copyFile("Archivo_A_Exportar.txt")
                asociacionesFile.copyFile("Archivo_A_Exportar.txt")
                starRatingFile.copyFile("Archivo_A_Exportar.txt")
                userFeedbackFile.copyFile("Archivo_A_Exportar.txt")
                mapFile.copyFile("Archivo_A_Exportar.txt")
    
                //Borrar los archivos por categorias.
                preguntasEncontradasFile.ereaseFile()
                preguntasNoEncontradaFile.ereaseFile()
                asociacionesFile.ereaseFile()
                starRatingFile.ereaseFile()
                userFeedbackFile.ereaseFile()
                mapFile.ereaseFile()
    
                //SocketIOManager.sharedInstance.sendMessage(exportFile.readFile())
                exportFile.ereaseFile()
            }
            else if !exportFile.fileIsEmpty() {
                //Escribir toda la data al archivo info.txt
                preguntasEncontradasFile.copyFile("Archivo_A_Exportar.txt")
                preguntasNoEncontradaFile.copyFile("Archivo_A_Exportar.txt")
                asociacionesFile.copyFile("Archivo_A_Exportar.txt")
                starRatingFile.copyFile("Archivo_A_Exportar.txt")
                userFeedbackFile.copyFile("Archivo_A_Exportar.txt")
                mapFile.copyFile("Archivo_A_Exportar.txt")
    
                //Borrar los archivos por categorias.
                preguntasEncontradasFile.ereaseFile()
                preguntasNoEncontradaFile.ereaseFile()
                asociacionesFile.ereaseFile()
                starRatingFile.ereaseFile()
                userFeedbackFile.ereaseFile()
                mapFile.ereaseFile()
    
                //SocketIOManager.sharedInstance.sendMessage(exportFile.readFile())
                exportFile.ereaseFile()
            }
        }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        checkFileWhenAppCloses()
        sleep(1)
        SocketIOManager.sharedInstance.closeConnection()
    }
}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        // Manages to also recieve push notifications on the foreground. ERC
        completionHandler(
            [UNNotificationPresentationOptions.alert,
             UNNotificationPresentationOptions.sound,
             UNNotificationPresentationOptions.badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        
            
            let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
            if isRegisteredForRemoteNotifications {
                // User is registered for notification
                //Suscribe a todos los usuarios a notificaciones del CAM
                Messaging.messaging().subscribe(toTopic: "/topics/CAM")
                print("subscribed to CAM Topic :)")
            }
        
        
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    // [END ios_10_data_message]
}



