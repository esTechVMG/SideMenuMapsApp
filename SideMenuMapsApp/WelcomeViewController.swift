//
//  ViewController.swift
//  SideMenuMapsApp
//
//  Created by esTechVMG on 18/1/21.
//

import UIKit
class WelcomeViewController: UIViewController {
    //Outlets
    @IBOutlet weak var mapBtnItem: UIBarButtonItem!
    @IBOutlet weak var webBtn: UIButton!
    
    override func viewDidLoad() {
       
        
        
        super.viewDidLoad()
        self.sideMenus()
    }
    func sideMenus() {
        if revealViewController() != nil{
            mapBtnItem.target = revealViewController()
            mapBtnItem.action = #selector(SWRevealViewController.revealToggle(_:))
            
            //webBtn.target = revealViewController()
            //rightButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            revealViewController()?.rearViewRevealWidth = 270
            revealViewController()?.rightViewRevealWidth = 160
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        }
    }

}

