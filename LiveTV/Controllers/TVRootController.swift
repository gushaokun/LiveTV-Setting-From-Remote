//
//  ViewController.swift
//  AppleTVDemo
//
//  Created by Gavin on 16/2/22.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit
import AVKit

class TVRootController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    
    var channels:NSDictionary?
    var section_names:[String]?
    var view_model:TVRootViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        headerView.frame = CGRect(x: 0, y: 0, width: CGRectGetWidth(self.tableView.frame), height: 540)
        view_model = TVRootViewModel(target: self)
        view_model!.intilizedData({ (data:NSDictionary?) -> (Void) in
            self.channels = data
            self.tableView.reloadData()
        })
       let names = (channels?.allKeys as? [String])!
        section_names = names.sort()
        tableView.tableFooterView = nil

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (channels?.count)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 280
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 80
        }
        return 40
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let height = (section == 0 ? 80 : 40)
        let view = UIView(frame: CGRect(x: 0, y: 0, width:Int(tableView.frame.size.width), height: height))
        view.backgroundColor = UIColor.clearColor()
        let title_label = UILabel()
        title_label.frame = CGRect(x: 30, y: 0, width: 300, height: height)
        title_label.font = UIFont.systemFontOfSize(50)
        title_label.textColor = UIColor.whiteColor()
        let title = section_names?[section]
        let titles = title?.componentsSeparatedByString("-") as Array?
        title_label.text = titles![1]
        view.addSubview(title_label)
        return view
    }
    
    func tableView(tableView: UITableView, canFocusRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? TVChannelTableCell
        let sub_channel_name = section_names![indexPath.section]
        let sub_channel = channels![sub_channel_name] as? [Dictionary<String,String>]
        cell?.configCellForViewModel(view_model!, sub_channels: sub_channel!)
        return cell!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

