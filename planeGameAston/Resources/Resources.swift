import UIKit

enum Resources {
    
    enum UserDefaultsKeys {
        static let blackHoleKey = "blackHole"
        static let planeKey = "plane"
        static let resultKey = "result"
    }
    
    enum String {
        enum MainVC {
            static var startGame = "START GAME"
            static var gameName = "SPACE WAR"
            static var settingsGame = "SETTINGS"
            static var statisticsGame = "STATISTICS"
        }
        
        enum GameVC {
            static var shakePhone = "Shake phone to start!"
            static var alertTitle = "Do you want to exit?"
            static var alertMessage = "score will be delete!"
            static var alertOK = "OK"
            static var alertCancel = "Cancel"
            static var gameOverText = "GAME OVER"
            static var dateFormatter = "d MM YYYY,h:mm:ss a"
        }
        
        enum StatisticsVC {
            static var cellName = "myCell"
            static var results = "RESULTS"
        }
        
        enum SettingsVC {
            static var easyLelelTitle = "Easy"
            static var midLevelTitle = "Mid"
            static var hardLevelTitle = "Hard"
            static var difficultyLevelDescriptionText = "CHOOSE GAME LEVEL"
            static var chooseSubmarineDescriptionText = "CHOOSE PLANE"
            static var firstPlaneType = "first"
            static var secondPlaneType = "second"
        }
    }
    
    enum Int {
        static var inset = 20
        static var insetBig = 100
        static var planeStep = 25
        static var planeAnimationDuration = 0.2
        static var timeInterval = 1
        static var blackHoleAnimatorY = 1000
        static var duration = 3
        static var multiple = 3
        static var backgroundAnimateY = 500
    }
    
    enum Images {
        static var backgroundImage = UIImage(named: "background")
        static var blackHoleImage = UIImage(named: "blackHole")
        static var planeImage = UIImage(named: "plane")
        static var fireImage = UIImage(named: "fire")
        static var boomImage = UIImage(named: "boom")
        static var exitButtonConfigImage = UIImage(systemName: "arrow.backward.square.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large))
        
    }
    enum Fonts {
        static var titleFont = UIFont.boldSystemFont(ofSize: 60)
        static var buttonFont = UIFont.boldSystemFont(ofSize: 30)
    }
    enum Frames {
        static var backgroundImageFrame = CGRect(x: 0, y: 0, width: 400, height: 900)
        static var planeFrame = CGRect(x: 165, y: 700, width: 75, height: 75)
        static var leftFireFrame = CGRect(x: -50, y: -1000, width: 100, height: 2000)
        static var rightFireFrame = CGRect(x: 350, y: -1000, width: 100, height: 2000)
        static var shakeDescriptionFrame = CGRect(x: 10, y: 10, width: 100, height: 30)
        static var blackHoleFrame = CGRect(x: .random(in: 30 ... 280), y: 0, width: 120, height: 120)
    }
}
