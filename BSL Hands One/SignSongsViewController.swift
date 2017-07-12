//
//  AnimalViewController.swift
//  BSL Hands One
//
//  Created by Thomas Maher on 23/06/2017.
//  Copyright © 2017 Thomas Maher. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import GoogleMobileAds

class SignSongsViewController: UIViewController, UIScrollViewDelegate, GADBannerViewDelegate {
    
    var heightValuePortrait : CGFloat = 1.0
    var heightValueLandscape : CGFloat = 1.0
    
    @IBOutlet weak var googleBanner: GADBannerView!
    @IBOutlet weak var scrollView: UIScrollView!
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer:AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.delegate = self
        self.scrollView.isScrollEnabled = true
        applyDeviceSpecificChecks()
        
        // Google Banner Script
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        googleBanner.adUnitID = "ca-app-pub-7466211922726741/7595203519"
        googleBanner.rootViewController = self
        googleBanner.delegate = self
        
        googleBanner.load(request)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AppGlobal.isLandscape() {
            
            DispatchQueue.main.async {
                self.scrollView.contentSize = CGSize(width:320, height: self.view.frame.size.height * self.heightValueLandscape)
                self.scrollView.setNeedsLayout()
            }
        }
        else{
            
            DispatchQueue.main.async {
                self.scrollView.contentSize = CGSize(width:320, height: self.view.frame.size.height * self.heightValuePortrait)
                self.scrollView.setNeedsLayout()
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        if AppGlobal.isLandscape() {
            
            DispatchQueue.main.async {
                self.scrollView.contentSize = CGSize(width:320, height: self.view.frame.size.height * self.heightValueLandscape)
                self.scrollView.setNeedsLayout()
            }
        }
        else{
            
            DispatchQueue.main.async {
                self.scrollView.contentSize = CGSize(width:320, height: self.view.frame.size.height * self.heightValuePortrait)
                self.scrollView.setNeedsLayout()
            }
        }
    }
    
    func applyDeviceSpecificChecks() {
        
        if Display.typeIsLike == DisplayType.iphoneSE {
            heightValuePortrait = 1.1
            heightValueLandscape = 1.3
        }
        else if Display.typeIsLike == DisplayType.iphone7 {
            heightValuePortrait = 1.1
            heightValueLandscape = 1.1
        }
        else if Display.typeIsLike == DisplayType.iphone7plus {
            heightValuePortrait = 1.1
            heightValueLandscape = 1.1
        }
        else if Display.typeIsLike == DisplayType.ipad9 {
            heightValuePortrait = 1.1
            heightValueLandscape = 1.1
        }
        else if Display.typeIsLike == DisplayType.ipad12 {
            heightValuePortrait = 1.1
            heightValueLandscape = 1.1
        }
    }

    @IBAction func lovemedoAction(_ sender: Any) {
        playVideo(url: "http://www.discoverycamp.co.uk/BT_Video/lovemedo.mp4")
    }
    
    @IBAction func countonmeAction(_ sender: Any) {
        playVideo(url: "http://www.discoverycamp.co.uk/BT_Video/countonme.mp4")
    }
    
    @IBAction func proudmaryAction(_ sender: Any) {
        playVideo(url: "http://www.discoverycamp.co.uk/BT_Video/proudmary.mp4")
    }
    
    
    
    func playVideo(url: String?) {
        
        let movieUrl:NSURL? = NSURL(string: url!)
        
        if let url = movieUrl {
            
            self.avPlayer = AVPlayer(url: url as URL)
            self.avPlayerViewController.player = self.avPlayer
        }
        
        self.present(self.avPlayerViewController, animated: true) { () -> Void in
            self.avPlayerViewController.player?.play() }
    }
}
