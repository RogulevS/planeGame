import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let gameNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Resources.String.MainVC.gameName
        label.font = Resources.Fonts.titleFont
        label.textColor = .orange
        label.textAlignment = .center
        return label
    }()
    
    private let startGame: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Resources.String.MainVC.startGame, for: .normal)
        button.titleLabel?.font = Resources.Fonts.buttonFont
        button.addTarget(self, action: #selector(showGameVC), for: .touchUpInside)
        button.tintColor = .orange
        return button
    }()
    
    private let settingsGame: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Resources.String.MainVC.settingsGame, for: .normal)
        button.titleLabel?.font = Resources.Fonts.buttonFont
        button.addTarget(self, action: #selector(showSettingsVC), for: .touchUpInside)
        button.tintColor = .orange
        return button
    }()
    
    private let statisticsGame: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Resources.String.MainVC.statisticsGame, for: .normal)
        button.titleLabel?.font = Resources.Fonts.buttonFont
        button.addTarget(self, action: #selector(showStatisticsVC), for: .touchUpInside)
        button.tintColor = .orange
        return button
    }()
    
    private var backgroundImage: UIImageView = {
        let view = UIImageView(image: Resources.Images.backgroundImage)
        view.frame = Resources.Frames.backgroundImageFrame
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstraints()
    }
    

    private func addSubviews() {
        
        view.addSubview(backgroundImage)
        view.addSubview(startGame)
        view.addSubview(gameNameLabel)
        view.addSubview(settingsGame)
        view.addSubview(statisticsGame)
    }

    
    private func setupConstraints() {
        
        gameNameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        startGame.snp.makeConstraints { make in
            make.top.equalTo(gameNameLabel).inset(200)
            make.centerX.equalToSuperview()
        }
        
        settingsGame.snp.makeConstraints { make in
            make.top.equalTo(startGame).inset(50)
            make.centerX.equalToSuperview()
        }
        
        statisticsGame.snp.makeConstraints { make in
            make.top.equalTo(settingsGame).inset(50)
            make.centerX.equalToSuperview()
        }
        
    }
    
    @objc private func showGameVC() {
        let gameVC = GameViewController()
        gameVC.modalTransitionStyle = .crossDissolve
        gameVC.modalPresentationStyle = .fullScreen
        
        self.present(gameVC, animated: true, completion: nil)
    }
    
    @objc private func showSettingsVC() {
        let settingsVC = SettingsViewController()
        settingsVC.modalTransitionStyle = .crossDissolve
        settingsVC.modalPresentationStyle = .fullScreen
        
        self.present(settingsVC, animated: true, completion: nil)
    }
    
    @objc private func showStatisticsVC() {
        let settingsVC = StatisticsViewController()
        settingsVC.modalTransitionStyle = .crossDissolve
        settingsVC.modalPresentationStyle = .fullScreen
        
        self.present(settingsVC, animated: true, completion: nil)
    }
    
}
