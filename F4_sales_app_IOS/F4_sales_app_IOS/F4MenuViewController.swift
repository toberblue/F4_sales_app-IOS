//
//  F4MenuViewController.swift
//  F4_sales_app_IOS
//
//  Created by Daniel Gratwicke on 7/04/17.
//  Copyright © 2017 Cherry Tree Limited. All rights reserved.
//

import UIKit

class F4MenuViewController: F4BaseViewController {
  
  @IBOutlet weak var logoImageView: UIImageView!
  @IBOutlet weak var menuItemsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupTableView()
  }
  
  class func getInstance() -> F4MenuViewController {
    return Constants.Storyboards.Main.storyboard.instantiateViewController(withIdentifier: Constants.Storyboards.Main.revealMenuVC) as! F4MenuViewController
  }
  
  func setupUI() {
    self.view.backgroundColor = Constants.Colors.mainOrange
    self.logoImageView.layoutIfNeeded()
    self.logoImageView.roundCorners(withRadius: self.logoImageView.frame.width/2)
  }
  
  func setupTableView() {
    menuItemsTableView.register(F4MenuItemCell.getNib(), forCellReuseIdentifier: F4MenuItemCell.getReuseID())
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func tappedTopWrapper(_ sender: Any) {
    //HGMenuManager.sharedManager.loadHomeViewController()
  }
  
}

/* Delegation and datasource extensions */

extension F4MenuViewController: SSASideMenuDelegate {}

extension F4MenuViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Constants.MenuItems.numberOfItems
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let menuItemCell = tableView.dequeueReusableCell(withIdentifier: F4MenuItemCell.getReuseID()) as! F4MenuItemCell
    let itemInfo = F4MenuHelper.GetMenuItemInfo(atIndexPath: indexPath)
    menuItemCell.itemLabel.text = itemInfo.title
    menuItemCell.iconImageView.image = UIImage.fontAwesomeIcon(name: itemInfo.icon, textColor: Constants.Colors.mainWhite, size: CGSize(width: 40, height: 40))
    return menuItemCell
  }
}

extension F4MenuViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    F4MenuHelper.MenuItemTapped(atIndexPath: indexPath)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 55
  }
}
