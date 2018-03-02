//
//  AppDelegate.swift
//  MyAutoLayOut
//
//  Created by MacBookPro on 2018. 2. 27..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
 //파이어 베이스 모듈
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
       
       var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print("AppDelegate 진입")
        // Override point for customization after application launch.
            FirebaseApp.configure()
        
            //Database.database().isPersistenceEnabled = true
            //let scoresRef = Database.database().reference()
            //scoresRef.keepSynced(true)
            //window객체 초기화
            window = UIWindow()
            //window객체를 code로 변경시켜주도록 설정
            window?.makeKeyAndVisible()
            
            //UICollectionViewFlowLayout 컬렉션 뷰 레이아웃과 관련된 객체
            let layout = UICollectionViewFlowLayout()
            //가로로 스크롤되게 설정
            layout.scrollDirection = .horizontal
            //SwipingController 객체를 생성하고 최상위 뷰로 설정
            let swipingController = SwipingController(collectionViewLayout: layout)
            window?.rootViewController = swipingController
            //파이어 베이스 초기화 코드
        
            return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

