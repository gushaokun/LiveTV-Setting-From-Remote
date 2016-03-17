//
//  RootViewModel.swift
//  LiveTV
//
//  Created by Gavin on 16/2/26.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class TVRootViewModel: NSObject {
    
    var controller:UIViewController?
    var channels:NSDictionary?
    let baseUrl = "http://60.214.208.202:9222/mweb/cmv/"

    override init() {
        super.init()
    }
    
    convenience init(target:UIViewController) {
        self.init()
        controller = target
    }
    
    func channelDatas() -> NSDictionary?{
        return channels
    }
    
    func intilizedData(complete:((NSDictionary?)->())){
        
        let data = NSData(contentsOfURL: NSURL(string: "http://media.devgsk.com/Channels.plist")!)
        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
        
        
        let docPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString
        
        let filePath = (docPath as String) + "/Channels.plist"
        
        let fileManager = NSFileManager()
        
        if fileManager.fileExistsAtPath(filePath) {
            print("fileIsAlreadyExist")
            channels = NSDictionary(contentsOfFile: filePath)
            complete(channels!)
            if data != nil{
                data?.writeToFile(filePath, atomically: true)
            }
            return
        }
        if data != nil {
            let result = data?.writeToFile(filePath, atomically: true)
            if result == false {
                complete(NSDictionary())
                return
            }
            channels = NSDictionary(contentsOfFile: filePath)
            complete(channels!)

        }else{
            complete(NSDictionary())
        }
    }
}
