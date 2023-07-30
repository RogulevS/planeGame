////
////  EnemyModel.swift
////  planeGameAston
////
////  Created by Rogulev Sergey on 05.07.2023.
////
//
//import UIKit
//
//class EnemyModel: UIView {
//    
//    var enemy: UIView
//    var isEnemyWin = false
//    
////    init(enemy: UIView, isEnemyWin: Bool) {
////        self.enemy = enemy
////        self.isEnemyWin = isEnemyWin
////    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//}
//
//
//import UIKit
//
//private extension CGFloat {
//    static let ufoSize = 60.0
//    static let ufoPadding = 170.0
//}
//
//final class UfoView: UIView {
//    
//    private let ufoSize: CGFloat = .ufoSize
//    private let ufoPadding: CGFloat = .ufoPadding
//    private var isCrashing = false
//    
//    override init(frame: CGRect) {
//        let newFrame = CGRect(x:.random(in:frame.minX + ufoPadding...frame.maxX - self.ufoPadding),
//                              y: frame.minY - ufoSize ,
//                              width: ufoSize,
//                              height: ufoSize)
//        super.init(frame: newFrame)
//        setupView()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupView()
//    }
//    
//    private func setupView() {
//        let imageView = UIImageView(frame: bounds)
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = UIImage(named: "Ufo")
//        addSubview(imageView)
//    }
//    
//}
