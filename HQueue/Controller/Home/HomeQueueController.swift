//
//  QueueControllerViewController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 06/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class HomeQueueController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var accountBtn: UIButton!
    
    enum CardState {
        case expanded
        case collapsed
    }
    var hospitalList: HospitalList!
    var cardViewController: UINavigationController!
    var visualEffectView:UIVisualEffectView!
    
    var cardHeight:CGFloat!
    let cardHandleAreaHeight:CGFloat = 150
    
    var cardVisible = false
    var nextState:CardState {
        if cardVisible {
            self.navigationController?.isNavigationBarHidden = false
            self.cardViewController.isNavigationBarHidden = true
            self.cardViewController.navigationBar.prefersLargeTitles = true
            self.hospitalList.view.addSubview(self.hospitalList.viewCardHandler)
            self.hospitalList.tableView.contentOffset.y = 1.8
            self.hospitalList.tableView.isScrollEnabled = false
            self.visualEffectView.alpha = 0
            return .collapsed
        }else{
            self.navigationController?.isNavigationBarHidden = true
            self.cardViewController.isNavigationBarHidden = false
            self.cardViewController.navigationBar.prefersLargeTitles = true
            self.hospitalList.viewCardHandler.removeFromSuperview()
            self.hospitalList.tableView.isScrollEnabled = true
            self.hospitalList.tableView.setContentOffset(CGPoint(x: 0, y: -100), animated: true)
            self.visualEffectView.alpha = 1
            return .expanded
        }
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "HomeQueueView", bundle: nil)
    }
    
    // MARK: Check Authentication
    fileprivate func checkAuth() {
        if UserDefaults.standard.string(forKey: "authToken") != nil {
            let nameuser = UserDefaults.standard.string(forKey: "authName")!
            self.userLabel.text = "Halo, \(nameuser)"
        }else{
            self.userLabel.text = "Halo, Sobat Sehat"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.hospitalList = HospitalList()

        self.title = "My Queue"
        self.navigationItem.titleView = UIView()
        self.setTransparantNav()
        
        // set height by main view
        cardHeight = self.view.frame.height - 44
        
        // Setup view
        self.accountBtn.layer.cornerRadius = self.accountBtn.frame.height / 2
        
        checkAuth()
        setupCard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        checkAuth()
    }
    
    //MARK: Push to AccountController
    @IBAction func tapAccount(_ sender: Any) {
        print("test")
        let loginVC = AccountController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        self.visualEffectView.alpha = 0
        
        cardViewController = UINavigationController(rootViewController: hospitalList)
        cardViewController.isNavigationBarHidden = true
        
        self.hospitalList.view.addSubview(self.hospitalList.viewCardHandler)
        cardViewController.view.roundCorners(corners: [.topLeft, .topRight], radius: 40)
        self.hospitalList.view.setShadow() // masih belum bisa di kasih bayangan
        
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        
        cardViewController.view.clipsToBounds = true
        
        let rightBtn = UIButton()
        rightBtn.setTitle("Tutup", for: .normal)
        
        self.hospitalList.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCardTap(recognzier:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(self.handleCardTap(recognzier:)))
        
        
        self.hospitalList.btnCardHandler.addGestureRecognizer(tapGestureRecognizer)
        rightBtn.addGestureRecognizer(tapGestureRecognizer2)
        
        /*
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleCardPan(recognizer:)))
        cardViewController.navigationBar.addGestureRecognizer(panGestureRecognizer)
        */
    }
    
    /*
    @objc func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.hospitalList.view)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }

    }
    */

    @objc func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    @IBAction func tapToDetailQueue(_ sender: Any) {
        let vc = DetailViewController()
        vc.queueEntity = "Example Data"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
