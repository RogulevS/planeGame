import UIKit
import CoreMotion

class GameViewController: UIViewController {
    
    private var counter = 0
    private var checkTimer = Timer()
    private var counterTimer = Timer()
    private var animatorForBlackHole: UIViewPropertyAnimator?
    private var gameResultArray = [GameResults]()
    private let dateFormatter = DateFormatter()
    private let date = Date()
    private let userDefaultsManager = UserDefaultsManager.shared
  
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = Resources.Fonts.buttonFont
        return label
    }()
    
    private lazy var plane: UIImageView = {
        let view = UIImageView()
        view.frame = Resources.Frames.planeFrame
        view.image = Resources.Images.planeImage
        view.contentMode = .scaleAspectFit
        view.isHidden = true
        return view
    }()

    var backgroundImage: UIImageView = {
        let view = UIImageView(image: Resources.Images.backgroundImage)
        view.frame = Resources.Frames.backgroundImageFrame
        return view
    }()
    
    var leftFireImage: UIImageView = {
        let view = UIImageView(image: Resources.Images.fireImage)
        view.frame = Resources.Frames.leftFireFrame
        return view
    }()
    
    var rightFireImage: UIImageView = {
        let view = UIImageView(image: Resources.Images.fireImage)
        view.frame = Resources.Frames.rightFireFrame
        return view
    }()
    
    var blackHoleImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private let boomImageView: UIImageView = {
        let view = UIImageView()
        guard let boomImage = Resources.Images.boomImage else { return view }
        view.image = boomImage
        return view
    }()
    
    private let exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Resources.Images.exitButtonConfigImage, for: .normal)
        button.tintColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shakeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .orange
        label.frame = Resources.Frames.shakeDescriptionFrame
        label.text = Resources.String.GameVC.shakePhone
        return label
    }()
    
    deinit {
        checkTimer.invalidate()
        counterTimer.invalidate()
    }
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        movePlane()
     
    }

    //MARK: - methods
    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(leftFireImage)
        view.addSubview(plane)
        view.addSubview(blackHoleImage)
        view.addSubview(rightFireImage)
        view.addSubview(scoreLabel)
        view.addSubview(boomImageView)
        view.addSubview(exitButton)
        view.addSubview(shakeDescriptionLabel)
    }
    
    private func setupConstraints() {
        shakeDescriptionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        scoreLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(Resources.Int.inset)
            make.top.equalToSuperview().inset(Resources.Int.inset)
        }
        exitButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Resources.Int.inset)
            make.top.equalToSuperview().inset(Resources.Int.inset)
        }
    }

    private func movePlane() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @IBAction func swipedLeft() {
        UIView.animate(withDuration: Resources.Int.planeAnimationDuration) {
            self.plane.frame.origin.x -= CGFloat(Resources.Int.planeStep)
        }
    }
    
    @IBAction func swipedRight() {
        UIView.animate(withDuration: Resources.Int.planeAnimationDuration) {
            self.plane.frame.origin.x += CGFloat(Resources.Int.planeStep)
        }
    }
    
    private func gameStarted() {
        plane.isHidden = false
        shakeDescriptionLabel.isHidden = true

        if let planeImageFilename = UserDefaults.standard.object(forKey: Resources.UserDefaultsKeys.planeKey) as? String,
        let blackHoleImageFilename = UserDefaults.standard.object(forKey: Resources.UserDefaultsKeys.blackHoleKey) as? String {
            
            let loadedPlaneImage = FileManager.loadImage(fileName: planeImageFilename)
            let loadedBlackHoleImage = FileManager.loadImage(fileName: blackHoleImageFilename)
            plane.image = loadedPlaneImage
            blackHoleImage.image = loadedBlackHoleImage
            counterTimer = Timer.scheduledTimer(timeInterval: TimeInterval(Resources.Int.timeInterval), target: self, selector: #selector(activateCounterTimer), userInfo: nil, repeats: true)
            counterTimer.fire()
            self.checkTimer = Timer.scheduledTimer(timeInterval: TimeInterval(Resources.Int.timeInterval), target: self, selector: #selector(intersectionCheck), userInfo: nil, repeats: true)
            checkTimer.fire()
            
        } else {
            
            plane.image = Resources.Images.planeImage
            blackHoleImage.image = Resources.Images.blackHoleImage
            counterTimer = Timer.scheduledTimer(timeInterval: TimeInterval(Resources.Int.timeInterval), target: self, selector: #selector(activateCounterTimer), userInfo: nil, repeats: true)
            counterTimer.fire()
            self.checkTimer = Timer.scheduledTimer(timeInterval: TimeInterval(Resources.Int.timeInterval), target: self, selector: #selector(intersectionCheck), userInfo: nil, repeats: true)
            checkTimer.fire()
        }
    }
    
    @objc private func exitButtonTapped() {
        switch counter {
        case 0:
            dismiss(animated: true, completion: nil)
            checkTimer.invalidate()
            counterTimer.invalidate()
            counter = 0
            
        default:
            animatorForBlackHole?.pauseAnimation()
      
            checkTimer.invalidate()
            counterTimer.invalidate()
            
            let alert = UIAlertController(title: Resources.String.GameVC.alertTitle, message: Resources.String.GameVC.alertMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: Resources.String.GameVC.alertOK, style: .default) { [weak self] _ in
                self?.animatorForBlackHole?.stopAnimation(true)
                self?.dismiss(animated: true, completion: nil)
            }
            
            let cancelAction = UIAlertAction(title: Resources.String.GameVC.alertCancel, style: .cancel) { [weak self] _ in
                self?.animatorForBlackHole?.startAnimation()
                self?.checkTimer = Timer.scheduledTimer(timeInterval: TimeInterval(Resources.Int.timeInterval), target: self ?? GameViewController(), selector: #selector(self?.intersectionCheck), userInfo: nil, repeats: true)
                self?.checkTimer.fire()
            
                self?.counterTimer = Timer.scheduledTimer(timeInterval: TimeInterval(Resources.Int.timeInterval), target: self ?? GameViewController(), selector: #selector(self?.activateCounterTimer), userInfo: nil, repeats: true)
                self?.counterTimer.fire()
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    @objc private func activateCounterTimer() {

        counter += 1
        scoreLabel.text = "\(counter)"
        
        if counter.isMultiple(of: Resources.Int.multiple) {
            blackHoleImage.frame = Resources.Frames.blackHoleFrame
            
            animatorForBlackHole = UIViewPropertyAnimator(duration: TimeInterval(Resources.Int.duration), curve: .linear, animations: {
                self.blackHoleImage.frame.origin.y = CGFloat(Resources.Int.blackHoleAnimatorY)
            })
            animatorForBlackHole?.startAnimation()
        }
    }
    
    @objc private func intersectionCheck() {
        
        guard let planeCheck = plane.layer.presentation() else { return }
        guard let leftFireCheck = leftFireImage.layer.presentation() else { return }
        guard let rightFireCheck = rightFireImage.layer.presentation() else { return }
        guard let blackHoleCheck = blackHoleImage.layer.presentation() else { return }
        
        guard let result = scoreLabel.text else { return }
        
        if  planeCheck.frame.intersects(leftFireCheck.frame) ||
            planeCheck.frame.intersects(rightFireCheck.frame) ||
            planeCheck.frame.intersects(blackHoleCheck.frame) ||
            blackHoleCheck.frame.intersects(planeCheck.frame) {
            
            boomImageView.frame = CGRect(x: self.plane.frame.origin.x, y: self.plane.frame.origin.y , width:
                                            self.plane.frame.width, height: self.plane.frame.height)
            
            self.plane.removeFromSuperview()
            self.blackHoleImage.removeFromSuperview()
            
            dateFormatter.dateFormat = Resources.String.GameVC.dateFormatter
            let dateString = dateFormatter.string(from: date)
            let gameResults = GameResults(result: result, resultDate: dateString)
            
            userDefaultsManager.saveResults(results: gameResults)
            
            let gameOverText = Resources.String.GameVC.gameOverText
            
            scoreLabel.text = gameOverText
            scoreLabel.textColor = .orange
            scoreLabel.font = Resources.Fonts.titleFont
            scoreLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            checkTimer.invalidate()
            counterTimer.invalidate()
            counter = 0
        }
    }
   
    func backgroundAnimate() {
        UIView.animate(withDuration: 0, delay: 0, options: .repeat, animations: {
            self.backgroundImage.frame.origin.y = CGFloat(Resources.Int.backgroundAnimateY)
        })
    }
 
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        switch motion {
        case .motionShake:
            gameStarted()
            backgroundAnimate()
            
        default:
            break
        }
    }
}



