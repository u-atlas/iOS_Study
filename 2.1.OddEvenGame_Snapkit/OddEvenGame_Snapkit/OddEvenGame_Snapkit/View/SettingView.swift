//
//  SettingView.swift
//  OddEvenGame_Snapkit
//
//  Created by 59 on 2022/02/28.
//

import UIKit
import Then
import SnapKit

protocol SubmitButtonDelegate {
    func buttonPressed(defaultBalls: String?)
}

class SettingView: UIView {

    // MARK: -- after Then Library
    // 텍스트 라벨
    var textLabel = UILabel().then {
        $0.text = "구슬 수를 입력하세요."
        $0.font = .systemFont(ofSize: 25.0, weight: .medium)
    }
    
    // Input
    var countInput = UITextField().then {
        // input 영역 테두리 설정
        $0.borderStyle = .line
        let string = "초기 구슬 수를 입력해주세요."
        let placeHolderText = NSAttributedString(string: string, attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        
        $0.resignFirstResponder()
        $0.attributedPlaceholder = placeHolderText
        $0.textAlignment = .center
        $0.keyboardType = UIKeyboardType.numberPad
    }

    // Stack
    var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 34
    }
    
    var submitBtn = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .lightGray
        
        // 버튼 눌렀을 때 동작 설정
        $0.addTarget(self, action: #selector(submitBtnPressed(_:)), for: .touchUpInside)
    }
    
    var delegate: SubmitButtonDelegate?
    var buttonPressed: ((_ defaultBalls: String?) -> ())?
    // 생성자를 통해서 뷰 위치 지정
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawCustomUI()
    }
    
    @available(*,unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    // 레이어 구성
    private func drawCustomUI() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(countInput)
        self.addSubview(submitBtn)
        
        countInput.snp.makeConstraints {
            $0.width.equalTo(200)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.centerY.equalToSuperview()
        }
        
        submitBtn.snp.makeConstraints { btn in
            btn.width.equalTo(80)
            btn.centerX.equalTo(self.snp.centerX)
            btn.top.equalTo(self.stackView.snp.bottom).offset(50)
        }

    }
}

extension SettingView {
    // MARK: - way1. Closure 활용
    @objc
    func submitBtnPressed(_ sender: UIButton) {
        self.buttonPressed?(self.countInput.text)
    }
    
    /*
     MARK: - way2. Delegate Pattern
    @objc
    func submitBtnPressed(_ sender: UIButton) {
        guard let count = self.countInput.text, let countInt = Int(count) else {
             self.delegate?.buttonPressed(defaultBalls: 0)
            return
        }
        self.delegate?.buttonPressed(defaultBalls: countInt)
    }
     */
}
