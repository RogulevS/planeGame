import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    private let difficultySelectionSegmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.insertSegment(withTitle: Resources.String.SettingsVC.easyLelelTitle, at: 0, animated: false)
        segment.insertSegment(withTitle: Resources.String.SettingsVC.midLevelTitle, at: 1, animated: false)
        segment.insertSegment(withTitle: Resources.String.SettingsVC.hardLevelTitle, at: 2, animated: false)
        segment.backgroundColor = .black
        segment.setTitleTextAttributes([
            .font: Resources.Fonts.buttonFont,
            .foregroundColor: UIColor.white.cgColor,
            .backgroundColor: UIColor.clear.cgColor],
                                       for: .normal)
        segment.selectedSegmentTintColor = .gray
        return segment
    }()
    
    private let difficultyLevelDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .orange
        label.text = Resources.String.SettingsVC.difficultyLevelDescriptionText
        label.font = Resources.Fonts.buttonFont
        return label
    }()
    
    private let exitButton: UIButton = {
        let button = UIButton()
        button.setImage(Resources.Images.exitButtonConfigImage, for: .normal)
        button.tintColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let choosePlaneDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .orange
        label.text = Resources.String.SettingsVC.chooseSubmarineDescriptionText
        label.font = Resources.Fonts.buttonFont
        return label
    }()
    
    private let planesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let planeSelectionSegmentedController: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.insertSegment(withTitle: Resources.String.SettingsVC.firstPlaneType, at: 0, animated: false)
        segment.insertSegment(withTitle: Resources.String.SettingsVC.secondPlaneType, at: 1, animated: false)
        segment.backgroundColor = .black
        segment.setTitleTextAttributes([
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.white.cgColor,
            .backgroundColor: UIColor.clear.cgColor],
                                       for: .normal)
        segment.selectedSegmentTintColor = .orange
        segment.addTarget(self, action: #selector(changeAndSavePlaneImage), for: .valueChanged)
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubview()
        setupConstraints()
    }
 
    private func addSubview() {
        view.addSubview(difficultySelectionSegmentControl)
        view.addSubview(planeSelectionSegmentedController)
        view.addSubview(choosePlaneDescriptionLabel)
        view.addSubview(difficultyLevelDescriptionLabel)
        view.addSubview(planesImageView)
        view.addSubview(exitButton)
    }
    
    private func setupConstraints() {
       
        planeSelectionSegmentedController.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(300)
        }
        difficultySelectionSegmentControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(planeSelectionSegmentedController).inset(300)
        }
        planesImageView.snp.makeConstraints { make in
            make.top.equalTo(planeSelectionSegmentedController).inset(10)
            make.left.right.equalToSuperview().inset(100)
        }
        difficultyLevelDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(difficultySelectionSegmentControl).inset(-50)
        }
        choosePlaneDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(planeSelectionSegmentedController).inset(-50)
        }
        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.left.equalToSuperview().inset(30)
        }
    }
     
    @objc private func changeAndSavePlaneImage() {
        switch planeSelectionSegmentedController.selectedSegmentIndex {
        case 0:
            guard let firstPlaneImage = UIImage(named: "fire") else { return }
            planesImageView.image = firstPlaneImage
            let savedImage = FileManager.saveImage(firstPlaneImage)
            UserDefaults.standard.set(savedImage, forKey: Resources.UserDefaultsKeys.planeKey)
            
        case 1:
            guard let secondPlaneImage = UIImage(named: "plane") else { return }
            planesImageView.image = secondPlaneImage
            let imageFileName = FileManager.saveImage(secondPlaneImage)
            UserDefaults.standard.set(imageFileName, forKey: Resources.UserDefaultsKeys.planeKey)
            
        default:
            guard let firstPlaneImage = UIImage(named: "fire") else { return }
            planesImageView.image = firstPlaneImage
            let imageFileName = FileManager.saveImage(firstPlaneImage)
            UserDefaults.standard.set(imageFileName, forKey: Resources.UserDefaultsKeys.planeKey)
        }
    }

    @objc private func exitButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
    
    

