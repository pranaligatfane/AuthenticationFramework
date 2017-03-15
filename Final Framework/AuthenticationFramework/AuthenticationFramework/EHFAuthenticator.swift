//
//  EHFAuthenticator.swift
//  AuthenticationFramework
//
//  Created by Pranalig on 14/03/17.
//  Copyright © 2017 kpit. All rights reserved.
//

import UIKit
import LocalAuthentication

public  typealias EHFCompletionBlock = (Void) ->()
public  typealias EHFAuthenticationErrorBlock = (Int) -> ()

public class EHFAuthenticator: NSObject
{
  fileprivate var context : LAContext
//    
//    // reason string presented to the user in auth dialog
//    var reason : NSString
//    
//    // Allows fallback button title customization. If set to nil, "Enter Password" is used.
//    var fallbackButtonTitle : NSString
//    
//
//    var useDefaultFallbackTitle : Bool
//    
//    // Disable "Enter Password" fallback button. Default value is NO.
//    var hideFallbackButton : Bool
//    
//    // Default value is LAPolicyDeviceOwnerAuthenticationWithBiometrics.  This value will be useful if LocalAuthentication.framework introduces new auth policies in future version of iOS.
    var policy : LAPolicy
//    

   public override init(){
        self.context = LAContext()
       // self.fallbackButtonTitle = ""
       // self.useDefaultFallbackTitle = false
      //  self.hideFallbackButton = false
        self.policy = .deviceOwnerAuthenticationWithBiometrics
       // self.reason = ""
    }
    
    
   public class func canAuthenticateWithError(error: NSErrorPointer) -> Bool{
        if (UserDefaults.standard.object(forKey: "touch_id_security") != nil){
            if UserDefaults.standard.bool(forKey: "touch_id_security") == false{
                return false
            }
        }
        else {
            return false
        }
        if ((NSClassFromString("LAContext")) != nil){
            if (EHFAuthenticator.init().context .canEvaluatePolicy(EHFAuthenticator.init().policy, error: nil)){
                return true
            }
            return false
        }
        return false
    }

    public func authenticateWithSuccess(_ success: @escaping EHFCompletionBlock, failure: @escaping EHFAuthenticationErrorBlock)
    {
            let context = LAContext()
           var authError : NSError?
           let reasonString = "Authentication is needed to access your app ! :)"
            
            if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics,  error: &authError){
                context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: {( authenticated , error) -> Void in
                    
                    if authenticated{
                         DispatchQueue.main.async(execute: {success()})
                    }else
                    {
                        return failure(error!._code)
                    }
                })
                
            }else{
                print(authError?.localizedDescription)
                failure(authError!.code)
            }
        }
    

}
