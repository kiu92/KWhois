//
//  KWhoisResultViewController.swift
//  KWhois
//
//  Created by kiu on 2020/7/21.
//  Copyright © 2020 kiu. All rights reserved.
//
//  KWhois查询结果页

import Foundation
import UIKit

class KWhoisResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var dataArray : [String]? = ["111111 \r\n\r\n111111", "222222", "333333"]

    private var tableview : UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = "KWhois结果"

        initView()
    }

    func initView() {

        tableview = UITableView.init(frame: CGRect.zero, style: .grouped)
        tableview?.delegate = self
        tableview?.dataSource = self
        tableview?.backgroundColor = UIColor.init(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        view.addSubview(tableview!)
        
        tableview?.snp.makeConstraints({ (make) in
            make.edges.equalTo(view)
        })

        // 自适应高度
        tableview?.estimatedRowHeight = 80
        tableview?.rowHeight = UITableView.automaticDimension
        
        tableview?.register(KWhoisResultTableViewCell.self, forCellReuseIdentifier: "tableviewcell")

    }

    //MARK:- UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.init()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = KWhoisResultTableViewCell(style:.value1, reuseIdentifier: "tableviewcell")
        cell.resultLabel?.text =  dataArray?[indexPath.section] ?? ""
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

}
