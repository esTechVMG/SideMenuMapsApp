//
//  ViewController.swift
//  SideMenuMapsApp
//
//  Created by esTechVMG on 18/1/21.
//

import UIKit
class WelcomeViewController: UIViewController {
    @IBOutlet weak var mapBtnItem: UIBarButtonItem!
    override func viewDidLoad() {
       
        
        
        super.viewDidLoad()
        self.sideMenus()
    }
    func sideMenus() {
        if revealViewController() != nil{
            mapBtnItem.target = revealViewController()
            mapBtnItem.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController()?.rearViewRevealWidth = UIScreen.main.bounds.width - 50
            view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        }
    }

}

