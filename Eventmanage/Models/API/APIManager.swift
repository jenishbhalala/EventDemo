//
//  APIManager.swift
//  Eventmanage
//
//  Created by Jenish on 25/06/19.
//  Copyright © 2019 Jenish. All rights reserved.
//


import UIKit
import Alamofire
import SystemConfiguration
import AVKit
import AVFoundation



class APIManager: NSObject {
    
    static let apiManager = APIManager()
    

    func getApi(url:String,param:AnyObject,isAuthentictaed: Bool,completionHandler:@escaping (AnyObject?, NSError?)->()) ->(){

        
        if NetConnection.isConnectedToNetwork() == false {

             callNetworkAlert()
            
        }
            
        
        let header = [String:String]()
        
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(encodedUrl!, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: header as [String:String]).responseJSON(completionHandler: { (response) in
            switch (response.result) {
            case .success:
                if let data = response.result.value as? [String: Any] {
                    print("--------------------------------------------------------------------")
                    print("URL : ",url)
                    print("--------------------------------------------------------------------")
                    print("Response : ", data)
                    print("--------------------------------------------------------------------")
                    if (data["message"] as? String == "Unauthenticated" || data["message"] as? String == "Unauthenticated")  {
                   
                    }
                    
                    completionHandler(data as AnyObject?, nil)
                }else if let data = response.result.value as? NSArray{
                    completionHandler(data as AnyObject?, nil)
                }
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
               
                    completionHandler(nil,response.result.error as NSError?)
                    
                }
              
                print("\n\nAuth request failed with error:\n \(error.localizedDescription)")
                break
            }
        })
    }
    func getApiEndoing(url:String,param:AnyObject,isAuthentictaed: Bool,completionHandler:@escaping (AnyObject?, NSError?)->()) ->(){
        
        
        var header = [String:String]()
  
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(encodedUrl ?? "", method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: header as [String:String]).responseJSON(completionHandler: { (response) in
            switch (response.result) {
            case .success:
                if let data = response.result.value as? [String: Any] {
                    print("--------------------------------------------------------------------")
                    print("URL : ",url)
                    print("--------------------------------------------------------------------")
                    print("Response : ", data)
                    print("--------------------------------------------------------------------")
                    if (data["message"] as? String == "Unauthenticated" || data["message"] as? String == "Unauthenticated") {
                       
                    }
                    
                    completionHandler(data as AnyObject?, nil)
                }else if let data = response.result.value as? NSArray{
                    completionHandler(data as AnyObject?, nil)
                }
                break
            case .failure(let error):
                if error._code == NSURLErrorTimedOut {
      
                    completionHandler(nil,response.result.error as NSError?)
                    
                }
          
                print("\n\nAuth request failed with error:\n \(error.localizedDescription)")
                break
            }
        })
    }
//    func checkNetworkConnectivity()->String
//    {
//
//        let network:Reachability = Reachability();
//        var networkValue:String = "" as String
//        
//        if(network.currentReachabilityStatus().rawValue==0)
//        {
//            networkValue = "NoAccess";
//        }
//        else if(network.currentReachabilityStatus().rawValue==1)
//        {
//            networkValue = "e";
//        }
//        else if(network.currentReachabilityStatus().rawValue==2)
//        {
//            networkValue = "wifi";
//        }
//        
//        return networkValue;
//    }
//    
//    func callNetworkAlert()
//    {
//        let alert = UIAlertController(title: "Bad Internet Connection!", message: "Please check your internet connection.", preferredStyle: UIAlertController.Style.alert)
//        let action1 = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (dd) -> Void in
//        }
//        alert.addAction(action1)
//    }
}

