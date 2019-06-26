//
//  EventDetailsVC.swift
//  Eventmanage
//
//  Created by Jenish on 25/06/19.
//  Copyright © 2019 Jenish. All rights reserved.
//

import UIKit

class EventDetailsVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var buttonEventLikeUnlike: UIButton!
    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var imageEventImages: UIImageView!
    @IBOutlet weak var labelEventDatetimes: UILabel!
    @IBOutlet weak var labelEventPlace: UILabel!
    
    //MARK: - Variables and constants
    var indexpath:Int = Int()
    var eventModelDisplay = [EventModel]()
    var FavouriteEvent = [Int]()
    
    //MARK: - View controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
        
        
        // Do any additional setup after loading the view.
    }
    func setupUI(){
        
        
        let getFavouriteEvent = UserDefaults.standard.array(forKey: "FavouriteEvent") ?? [] as! [Int]
        self.FavouriteEvent.removeAll()
        self.FavouriteEvent = getFavouriteEvent as! [Int]
        
        if FavouriteEvent.contains(eventModelDisplay[indexpath].id){
            self.buttonEventLikeUnlike.isSelected = true
            
        }else{
            self.buttonEventLikeUnlike.isSelected = false
        }
        
        
        
        imageEventImages.layer.masksToBounds = false
        imageEventImages.layer.cornerRadius = imageEventImages.frame.height / 16
        imageEventImages.clipsToBounds = true
        
        if eventModelDisplay[indexpath].image != ""{
          self.imageEventImages.sd_setImage(with: URL(string:eventModelDisplay[indexpath].image))
        }else{
            self.imageEventImages.image = #imageLiteral(resourceName: "image_event_default")
        }
        
       // self.imageEventImages.sd_setImage(with: URL(string:eventModelDisplay[indexpath].image))
        self.labelEventName.text = eventModelDisplay[indexpath].eventname
        self.labelEventPlace.text = eventModelDisplay[indexpath].place
        self.labelEventDatetimes.text = eventModelDisplay[indexpath].datetime
        
        
        
        
        
    }
    
    @IBAction func onClickLikeUnlike(_ sender: Any) {
        
        if buttonEventLikeUnlike.isSelected == true{
            if FavouriteEvent.contains(eventModelDisplay[indexpath].id){
                
                FavouriteEvent = FavouriteEvent.filter() { $0 != eventModelDisplay[indexpath].id }
                UserDefaults.standard.set(FavouriteEvent, forKey: "FavouriteEvent")
            }
            
            self.buttonEventLikeUnlike.isSelected = false
        }else{
            FavouriteEvent.append(eventModelDisplay[indexpath].id)
            self.buttonEventLikeUnlike.isSelected = true
            UserDefaults.standard.set(FavouriteEvent, forKey: "FavouriteEvent")
            
        }
        
        
        
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
