//
//  ViewController.swift
//  Eventmanage
//
//  Created by Jenish on 25/06/19.
//  Copyright © 2019 Jenish. All rights reserved.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController,UISearchBarDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var tableviewEventTable: UITableView!
    @IBOutlet weak var Searbar: UISearchBar!
    
    //MARK: - Variables and constants
    var EventModels = [EventModel]()
    var FavouriteEvent = [Int]()
    
    //MARK: - View controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUpSearchBar()

    }
    
    func setupUI(){
        self.navigationController?.isNavigationBarHidden = true
        self.getEventdata()
        tableviewEventTable.delegate = self
        tableviewEventTable.dataSource = self
        tableviewEventTable.register(UINib(nibName: "tableviewcellEvent", bundle: nil), forCellReuseIdentifier: "tableviewcellEvent")
        tableviewEventTable.sectionIndexBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.tableviewEventTable.reloadData()
    }
    private func setUpSearchBar(){
        Searbar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let getFavouriteEvent = UserDefaults.standard.array(forKey: "FavouriteEvent") ?? [] as! [Int]
        self.FavouriteEvent.removeAll()
        self.FavouriteEvent = getFavouriteEvent as! [Int]
        tableviewEventTable.reloadData()
        
    }
    
    //MARK: API
    func getEventdata() {
        var dict = NSMutableDictionary()
        dict = ["": ""]
        
        showProgress()
        //let url = "https://api.seatgeek.com/2/events?client_id=MTcxNzc4OTV8MTU2MTQzODExMS45Ng&q=Texas Ranger"
        let url = "https://api.seatgeek.com/2/events?client_id=MTcxNzc4OTV8MTU2MTQzODExMS45Ng"
        APIManager.apiManager.getApi(url: url, param: dict, isAuthentictaed: false) { (response, error) in
         hideProgress()
            guard let _ = response else {
                return
            }
            if let dict = response as? NSDictionary {
                
                if let data = dict.value(forKey: "events") as? NSArray {
                    self.EventModels.removeAll()
                    for dictData in data {
                        self.EventModels.append(EventModel.init(attrDict:dictData as! NSDictionary))
                    }
                    
                    let getFavouriteEvent = UserDefaults.standard.array(forKey: "FavouriteEvent") ?? [] as! [Int]
                    self.FavouriteEvent.removeAll()
                    self.FavouriteEvent = getFavouriteEvent as! [Int]
                    
                }
            }
            self.tableviewEventTable.reloadData()
            
        }
    }
    
    
    //MARK: Search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        var dict = NSMutableDictionary()
        dict = ["": ""]
        let url = "https://api.seatgeek.com/2/events?client_id=MTcxNzc4OTV8MTU2MTQzODExMS45Ng&q=" + searchBar.text!
        APIManager.apiManager.getApi(url: url, param: dict, isAuthentictaed: false) { (response, error) in
            guard let _ = response else {
                return
            }
            if let dict = response as? NSDictionary {
                
                if let data = dict.value(forKey: "events") as? NSArray {
                    self.EventModels.removeAll()
                    for dictData in data {
                        self.EventModels.append(EventModel.init(attrDict:dictData as! NSDictionary))
                    }
                    let getFavouriteEvent = UserDefaults.standard.array(forKey: "FavouriteEvent") ?? [] as! [Int]
                    self.FavouriteEvent.removeAll()
                    self.FavouriteEvent = getFavouriteEvent as! [Int]
                    
                }
            }
            self.tableviewEventTable.reloadData()
        }
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        getEventdata()
        searchBar.text = ""
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard searchBar.text != nil  else {
            return
        }
    }
    
}
extension HomeVC :UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableviewEventTable.dequeueReusableCell(withIdentifier: "tableviewcellEvent", for: indexPath) as! tableviewcellEvent

        if FavouriteEvent.contains(EventModels[indexPath.row].id){
            cell.imageEventLike.isHidden = false
            cell.imageEventLike.image = #imageLiteral(resourceName: "icon_heart_border")
            
        }else{
            cell.imageEventLike.isHidden = true
        }
        
        cell.labelEventname.text = EventModels[indexPath.row].eventname
        cell.labelEventPlaceName.text = EventModels[indexPath.row].place
        cell.labelEventDateTime.text = EventModels[indexPath.row].datetime
        
        if EventModels[indexPath.row].image != ""{
        cell.imageEventImages.sd_setImage(with: URL(string:EventModels[indexPath.row].image))
        }else{
              cell.imageEventImages.image = #imageLiteral(resourceName: "image_event_default")
        }
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EventDetailsVC") as? EventDetailsVC
        vc?.indexpath = Int(indexPath.row)
        vc?.eventModelDisplay = EventModels
        self.navigationController?.pushViewController(vc!, animated: true)

    }
  
}

