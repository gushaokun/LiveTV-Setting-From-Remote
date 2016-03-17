//
//  ChannelTableCell.swift
//  LiveTV
//
//  Created by Gavin on 16/2/26.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class TVChannelTableCell: UITableViewCell, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var channelCollectionView: UICollectionView!
    
    var channels:[Dictionary<String,String>] = []
    var viewModel:TVRootViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCellForViewModel(model:TVRootViewModel, sub_channels:[Dictionary<String,String>]){
        
        viewModel = model
        channels = sub_channels
        channelCollectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(400 , 200)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! TVCollectionViewCell
        let channelData = channels[indexPath.row]
        let imagename = channelData["icon"]
        let title = channelData["name"]
        cell.titleView.text = title
        let image = UIImage(named: imagename!+".jpg")
        cell.iconImageView.image = UIImage(named: imagename!+".jpg")
        cell.nameView.text = title
        cell.nameView.hidden = (image != nil)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        let channe_data = channels[indexPath.row]
        let channel_url = channe_data["url"]
        var play_url = ""
        if channel_url!.containsString("http://"){
            play_url = channel_url!
        }else{
            play_url = "\(viewModel!.baseUrl)\(channel_url).m3u8"
        }
        let player_controller = TVPlayerController()
        player_controller.urlString = play_url
        viewModel?.controller?.presentViewController(player_controller, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, canFocusItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    func collectionView(collectionView: UICollectionView, didUpdateFocusInContext context: UICollectionViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        let ncell = context.nextFocusedView as? TVCollectionViewCell
        let pcell = context.previouslyFocusedView as? TVCollectionViewCell
        coordinator.addCoordinatedAnimations({ () -> Void in
            ncell?.titleView.alpha = 1
            pcell?.titleView.alpha = 0
            }, completion: nil)
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
