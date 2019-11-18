//
//  QueueControllerViewController.swift
//  HQueue
//
//  Created by Faridho Luedfi on 06/11/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit

class HomeQueueController: UIViewController {
    
    @IBOutlet weak var accountTumb: AccountThumbnail!
    @IBOutlet weak var userLabel: UILabel!
    
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
            return .collapsed
        }else{
            self.navigationController?.isNavigationBarHidden = true
            self.cardViewController.isNavigationBarHidden = false
            self.cardViewController.navigationBar.prefersLargeTitles = true
            self.hospitalList.viewCardHandler.removeFromSuperview()
            return .expanded
        }
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "HomeQueueView", bundle: nil)
    }

    fileprivate func checkAuth() {
        if UserDefaults.standard.string(forKey: "authToken") != nil {
            let nameuser = UserDefaults.standard.string(forKey: "authName")!
            self.userLabel.text = "Hi, \(nameuser)"
            self.userLabel.alpha = 1
        }else{
            self.userLabel.alpha = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hospitalList = HospitalList()
        
        self.title = "My Queue"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: accountTumb)
        accountTumb.translatesAutoresizingMaskIntoConstraints = false
        accountTumb.widthAnchor.constraint(equalToConstant: accountTumb.frame.height).isActive = true
        accountTumb.heightAnchor.constraint(equalToConstant: accountTumb.frame.height).isActive = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        cardHeight = self.view.frame.height - 44
        
        checkAuth()
        
        setupCard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkAuth()
    }
    
     //TODO: Change this into account method
    @IBAction func tapAccount(_ sender: Any) {
        print("test")
        let loginVC = AccountController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
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
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleCardPan(recognizer:)))
        
        self.hospitalList.viewCardHandler.addGestureRecognizer(tapGestureRecognizer)
        rightBtn.addGestureRecognizer(tapGestureRecognizer2)
        
        //cardViewController.navigationBar.addGestureRecognizer(panGestureRecognizer)
    }

    @objc func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
//    @objc func handleCardPan (recognizer:UIPanGestureRecognizer) {
//        switch recognizer.state {
//        case .began:
//            startInteractiveTransition(state: nextState, duration: 0.9)
//        case .changed:
//            let translation = recognizer.translation(in: self.hospitalList.view)
//            var fractionComplete = translation.y / cardHeight
//            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
//            updateInteractiveTransition(fractionCompleted: fractionComplete)
//        case .ended:
//            continueInteractiveTransition()
//        default:
//            break
//        }
//
//    }
    
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
            
            
            // TODO : Remove this
//            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
//                switch state {
//                case .expanded:
//                    self.cardViewController.view.layer.cornerRadius = 12
//                case .collapsed:
//                    self.cardViewController.view.layer.cornerRadius = 0
//                }
//            }
//
//            cornerRadiusAnimator.startAnimation()
//            runningAnimations.append(cornerRadiusAnimator)
            
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

}
