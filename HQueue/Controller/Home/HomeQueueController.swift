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
    
    @IBOutlet weak var queueSisaAntrian: UILabel!
    @IBOutlet weak var queueHospitalName: UILabel!
    @IBOutlet weak var queuePoliName: UILabel!
    @IBOutlet weak var queueDoctorName: UILabel!
    
    enum CardState {
        case expanded
        case collapsed
    }
    var hospitalList: HospitalList!
    var cardViewController: QueueNavigationController!
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
        if self.isLogged() {
            let nameuser = UserDefaults.standard.string(forKey: UserEnv.authName.rawValue)!
            self.userLabel.text = "Halo, \(nameuser)"
        self.accountBtn.setTitle(String(nameuser.character(at: 0)!), for: .normal)
        }else{
            self.userLabel.text = "Halo, Sobat Sehat"
            self.accountBtn.setTitle("A", for: .normal)
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

        setupCard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchCurrentQueueNotificationHandler(_:)), name: NSNotification.Name(ActionIdentifiersNotif.updateQueueCategory), object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        checkAuth()
        fetchCurrentQueue()
        
        
    }
    
    //MARK: Push to AccountController
    @IBAction func tapAccount(_ sender: Any) {
        print("test")
        let loginVC = AccountController()
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    //MARK: Fetch Current Queue
    
    @objc func fetchCurrentQueueNotificationHandler(_ notification: Notification?) {
        print("fetchCurrentQueueNotificationHandler")
        self.fetchCurrentQueue()
    }
    
    func fetchCurrentQueue() {
        let networkManager = NetworkManager()
        self.setIsInQueue(false)
        if self.isLogged() && self.ifIsVerifed() {
            networkManager.getCurrentQueue { queue, error in
                if error != nil {
                    DispatchQueue.main.async {
                        self.presentAlert(
                            alert: UIAlertController(title: "Info", message: error, preferredStyle: .alert),
                            actions: [
                                .init(title: "Close", style: .default, handler: { action in
                                    self.fetchCurrentQueue()
                                })
                            ],
                            comletion: nil)
                    }
                }
                
                if let dataQueue = queue?.data, queue!.success {
                    DispatchQueue.main.async {
                        self.setIsInQueue(true)
                        self.setupQueueData(queueEntity: dataQueue)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.setupQueueDataToDefault()
                    }
                }
                
            }
        } else {
            DispatchQueue.main.async {
                self.setupQueueDataToDefault()
            }
        }
    }
    
    func setupQueueData(queueEntity: QueueEntity) {
        self.queueSisaAntrian.text = String( queueEntity.queueRemaining )
        self.queueHospitalName.text = queueEntity.hospital.name
        self.queuePoliName.text = queueEntity.poliName
        self.queueDoctorName.text = queueEntity.doctor.name
    }
    
    func setupQueueDataToDefault() {
        self.queueSisaAntrian.text = "0"
        self.queueHospitalName.text = "Belum ada antrian"
        self.queuePoliName.text = "Pilih \"Cari RS\" untuk memulai antrian"
        self.queueDoctorName.text = ""
    }
    
    //MARK: Setup View
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        self.visualEffectView.alpha = 0
        
        cardViewController = QueueNavigationController(rootViewController: hospitalList)
        cardViewController.queueNavigationDelegate = self
        cardViewController.isNavigationBarHidden = true
        
        self.hospitalList.view.addSubview(self.hospitalList.viewCardHandler)
        cardViewController.view.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        self.hospitalList.view.setShadow() // masih belum bisa di kasih bayangan
        
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        
        cardViewController.view.clipsToBounds = true
        
        let rightBtn = UIButton()
        rightBtn.setTitle("Tutup", for: .normal)
        rightBtn.setTitleColor(.HQueueDarkBlue, for: .normal)
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
    
    // MARK: Handle Gesture Floating Card
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
    
    //MARK: Navigation
    @IBAction func tapToDetailQueue(_ sender: Any) {
        if self.isInQueue() {
            let vc = DetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func toQueueHistoryList(_ sender: Any) {
        let vc = self.isLogged() ? QueueHistoryController() : AccountController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HomeQueueController: QueueNavigationControllerDelegate {
    func didRegisterQueue() {
        animateTransitionIfNeeded(state: nextState, duration: 0.9)
        self.fetchCurrentQueue()
    }
}
