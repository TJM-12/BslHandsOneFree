//
//  ViewController.swift
//  Scroll View
//
//  Created by Thomas Maher on 22/06/2017.
//  Copyright © 2017 Thomas Maher. All rights reserved.
//
import UIKit
import AVFoundation
import AVKit
import GoogleMobileAds

class ViewController: UIViewController,UIScrollViewDelegate, GADInterstitialDelegate {
    
    var heightValuePortrait : CGFloat = 1.0
    var heightValueLandscape : CGFloat = 1.0
    
    //adMob
    var banner: GADBannerView!
    var fullScreenAds : GADInterstitial!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    let avPlayerViewController = AVPlayerViewController()
    var avPlayer:AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.scrollView.isScrollEnabled = true
        applyDeviceSpecificChecks()
        
        
        // Google Banner Script
        
        banner = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait) // Only Poertrait
        banner.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        banner.rootViewController = self
        let req:GADRequest = GADRequest()
        banner.load(req)
        banner.frame = CGRect(x: 0, y: view.bounds.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        self.view.addSubview(banner)
        
        // End
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
            heightValuePortrait = 1.6
            heightValueLandscape = 2.9
        }
        else if Display.typeIsLike == DisplayType.iphone7 {
            heightValuePortrait = 1.4
            heightValueLandscape = 2.4
        }
        else if Display.typeIsLike == DisplayType.iphone7plus {
            heightValuePortrait = 1.3
            heightValueLandscape = 2.3
        }
        else if Display.typeIsLike == DisplayType.ipad9 {
            heightValuePortrait = 1.4
            heightValueLandscape = 1.8
        }
        else if Display.typeIsLike == DisplayType.ipad12 {
            heightValuePortrait = 1.1
            heightValueLandscape = 1.4
        }
    }
    
    // BEGINNING
    @IBAction func alphabetAction(_ sender: Any) {
        self.fullScreenAds = CreatAndLoadInterstitial()
    }
    func CreatAndLoadInterstitial() -> GADInterstitial? {
        fullScreenAds = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/1033173712")
        guard let fullScreenAds = fullScreenAds else {
            return nil
        }
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        fullScreenAds.load(request)
        fullScreenAds.delegate = self
        
        return fullScreenAds
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("Ads Loaded")
        ad.present(fromRootViewController: self)
    }
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print("Ads not loaded")
    }
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        playVideo(url: "http://www.discoverycamp.co.uk/BT_Video/Alphabet.mp4")
    }
    
    // END

    
    @IBAction func coloursAction(_ sender: Any) {
        playVideo(url: "http://www.discoverycamp.co.uk/BT_Video/Colours.mp4")
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


