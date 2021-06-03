//
//  HomeScreenViewController.swift
//  MyMediaApp
//
//  Created by harsh_TTN on 28/04/21.
//  Copyright © 2021 harsh_TTN. All rights reserved.
//

import UIKit
import SideMenu

class HomeScreenViewController: UIViewController, MenuControllerDelegate {
    
    @IBOutlet weak var homeScreenTableView: UITableView!
    
    let homeVM = HomeViewModel()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchHomeScreenData), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    private var sideMenu: SideMenuNavigationController?
    private let employeeController = EmployeeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeScreenTableView.addSubview(self.refreshControl)
        homeScreenTableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        homeScreenTableView.register(BannerTableViewCell.nib(), forCellReuseIdentifier: BannerTableViewCell.identifier)
        homeScreenTableView.delegate = self
        homeScreenTableView.dataSource = self
        homeScreenTableView.estimatedRowHeight = UITableView.automaticDimension
        homeScreenTableView.rowHeight = UITableView.automaticDimension
        fetchHomeScreenData()
        
        // Do any additional setup after loading the view.
        let menu = MenuController(with: SideMenuItem.allCases)
        
        menu.delegate = self
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        sideMenu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        addChildControllers()
    }
    
    private func addChildControllers() {
        addChild(employeeController)
        view.addSubview(employeeController.view)
        employeeController.view.frame = view.bounds
        employeeController.didMove(toParent: self)
        employeeController.view.isHidden = true

    }
    
    @IBAction func menuBarButtonTouchUpInside (){
        present(sideMenu!, animated: true)
    }
    
    func didSelectMenuItem(menuOption: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)
        
        
        switch menuOption {
        case .home:
            employeeController.view.isHidden = true
        case .location:
            employeeController.view.isHidden = true
        case .movies:
            employeeController.view.isHidden = true
        case .notification:
            employeeController.view.isHidden = true
        case .employee:
            employeeController.view.isHidden = true
        case .country:
            employeeController.view.isHidden = true
        case .language:
            employeeController.view.isHidden = true
        case .aboutus:
            employeeController.view.isHidden = true
        case .faq:
            employeeController.view.isHidden = true
        case .changetheme:
            employeeController.view.isHidden = true
        case .logout:
            employeeController.view.isHidden = true
           
        }
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.current.background
        homeScreenTableView.backgroundColor = Theme.current.background
        
    }
    
    @objc func fetchHomeScreenData(){
        homeVM.fetchHomeApiData { (success, message) in
            self.refreshControl.endRefreshing()
            if success {
                self.homeScreenTableView.reloadData()
            } else {
                print(message)
            }
        }
    }
    func openDetailScreen(_ sectionIndex: Int, _ itemIndex: Int) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailScreenViewController") as! DetailScreenViewController
        vc.data = homeVM.homeApiData[sectionIndex].movieData?[itemIndex]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeVM.homeApiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = homeScreenTableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as! BannerTableViewCell
            cell.cellIndex = indexPath.row
            cell.delegate = self
            cell.configure(homeVM.homeApiData[indexPath.row])
            return cell
        } else {
            let cell = homeScreenTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
            cell.cellIndex = indexPath.row
            cell.delegate = self
            cell.configure(homeVM.homeApiData[indexPath.row])
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return homeScreenTableView.frame.width * (9/16)
        } else {
            return 200.0
            //return UITableView.automaticDimension
        }
    }
    

    
}


extension HomeScreenViewController: CustomTableCellProtocol, BannerTableCellProtocol {
    func bannerTapped(sectionIndex: Int, itemIndex: Int) {
        openDetailScreen(sectionIndex, itemIndex)
    }
    
    func cellTapped(sectionIndex: Int, itemIndex: Int) {
        openDetailScreen(sectionIndex, itemIndex)
    }

}
