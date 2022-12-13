//
//  WriteButton.swift
//  MateList
//
//  Created by 강민규 on 2022/12/13.
//

import UIKit

final class WriteButton: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}

extension WriteButton {
    func configureUI() {
        let writeButtonText: UILabel = UILabel()
        
        self.addSubview(writeButtonText)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.layer.cornerRadius = 17.5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(rgb: 0xE5E5E5).cgColor
        
        
        writeButtonText.text = "글쓰기"
        writeButtonText.font = UIFont.boldSystemFont(ofSize: 16)
        writeButtonText.textColor = .black
        writeButtonText.translatesAutoresizingMaskIntoConstraints = false
        
        writeButtonText.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
