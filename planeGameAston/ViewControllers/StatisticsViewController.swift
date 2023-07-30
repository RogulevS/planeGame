import UIKit
import SnapKit

class StatisticsViewController: UIViewController {
    
    //MARK: - properties
    private let myTableView = UITableView()
    private var gameResultArray = [GameResults]()
    private let userDefaultsManager = UserDefaultsManager.shared
    private let idCell = Resources.String.StatisticsVC.cellName
    
    private let exitButton: UIButton = {
        let button = UIButton()
        let buttonConfiguration = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
        button.setImage(Resources.Images.exitButtonConfigImage, for: .normal)
        button.tintColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Resources.String.StatisticsVC.results
        label.textColor = .orange
        label.font = Resources.Fonts.buttonFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        addSubView()
        addTableView()
        setupConstraints()
        guard let resultsArray = userDefaultsManager.receiveResults() else { return }
        gameResultArray = resultsArray
    }
    
    //MARK: - methods
    @objc private func exitButtonTapped() {
        self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func addTableView() {
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: idCell)
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        self.myTableView.backgroundColor = .black
    }
    
    private func setupConstraints() {
        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Resources.Int.inset)
            make.left.equalToSuperview().inset(Resources.Int.inset)
        }
        topLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(Resources.Int.insetBig)
        }
        myTableView.snp.makeConstraints { make in
            make.top.equalTo(topLabel).inset(Resources.Int.insetBig)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func addSubView() {
        self.view.addSubview(exitButton)
        self.view.addSubview(topLabel)
        self.view.addSubview(myTableView)
    }
}

extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameResultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(indexPath.row + 1). \(gameResultArray[indexPath.row].resultDate): \(gameResultArray[indexPath.row].result ?? "")"
        cell.contentConfiguration = content
        
        return cell
    }
}

    

