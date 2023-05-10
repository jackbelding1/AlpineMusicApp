//
//  PushNotificationManager.swift
//  Alpine Music App
//
//  Created by Jack Belding on 5/3/23.
//

import Firebase
import FirebaseFirestore
import FirebaseMessaging
import UIKit
import UserNotifications

class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
    // id for firebase messanger
    let userID: String
    
    init(userID: String) {
        self.userID = userID
        super.init()
    }
    
    // register the user to recieve push notifications
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
        updateFirestorePushTokenIfNeeded()
    }
    
    // update user firebase token
    func updateFirestorePushTokenIfNeeded() {
        if let token = Messaging.messaging().fcmToken {
            let usersRef = Firestore.firestore().collection("users_table").document(userID)
            usersRef.setData(["fcmToken": token], merge: true)
        }
    }
    
    // handle notification
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  willPresent notification: UNNotification) async
        -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo

        // Print full message.
        print(userInfo)

        // Change this to your preferred presentation option
        return [[.alert, .sound]]
      }

    // completion handler for successful registration token fetch
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // subscribe user to general topic to recieve notifications
        Messaging.messaging().subscribe(toTopic: "topic") { error in
          print("Subscribed to topic topic")
        }
        updateFirestorePushTokenIfNeeded()
    }
    
    // handle user tap notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //
        // TODO: refactor keywindow
        //
        // grab the window
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        // open live stream view
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            AVPlayerManager.shared.playLiveStream(topController)
        }
        completionHandler()
    }
}
