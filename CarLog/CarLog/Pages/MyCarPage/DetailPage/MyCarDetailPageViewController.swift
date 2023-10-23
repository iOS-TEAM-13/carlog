//
//  MyCarPageDetailViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/18.
//

import SnapKit
import SwiftUI
import UIKit

class MyCarDetailPageViewController: UIViewController {
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .buttonSkyBlueColor
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private var selectedTitleLabel: UILabel = {
        var label = UILabel()
        label.customLabel(text: "이름", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), alignment: .left)
        return label
    }()
    
    lazy private var selectedprogressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .white
        view.progressTintColor = .mainNavyColor
        view.progress = 0.1
        return view
    }()
    
    private var selectedIntervalLabel: UILabel = {
        var label = UILabel()
        label.customLabel(text: "기간", textColor: .systemGray, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua10, weight: .medium), alignment: .left)
        return label
    }()
    
    private let selectedImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.forward")
        view.tintColor = .mainNavyColor
        return view
    }()
    
    lazy private var buttonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [modifiedButton, completedButton])
        view.customStackView(spacing: Constants.horizontalMargin * 2, axis: .horizontal, alignment: .fill)
        view.distribution = .fillEqually
        return view
    }()
    
    private let modifiedButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "날짜 변경", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), titleColor: .white, backgroundColor: .mainNavyColor)
        return button
    }()
    
    private let completedButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "점검 완료", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium), titleColor: .white, backgroundColor: .mainNavyColor)
        return button
    }()
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var detailCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.register(MyCarDetialViewCell.self, forCellWithReuseIdentifier: MyCarDetialViewCell.identifier)
        return view
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        return picker
    }()
    
    let textField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .buttonSkyBlueColor
        field.layer.cornerRadius = 10
        return field
    }()
    
    // MARK: Dummy
    var selectedParts: PartsInfo?
//    var selectedInsurance: (String, InsuranceInfo)?
    var selectedProgress: Double?
    var selectedInterval: String?
    var selectedIcon: UIImage?
    
    var saveData: CarPart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
//        if selectedInsurance?.0 == nil {
//            configureParts()
//        } else {
//            configureInsurance()
//        }
        configureUI()
        setupUI()
        setCollectionView()
        addButtonActions()
        loadCarParts()
    }
    
    private func setupUI() {
        view.addSubview(backgroundView)
        view.addSubview(buttonStackView)
        view.addSubview(detailCollectionView)
        
        backgroundView.addSubview(selectedTitleLabel)
        backgroundView.addSubview(selectedprogressView)
        backgroundView.addSubview(selectedIntervalLabel)
        backgroundView.addSubview(selectedImageView)
        
        backgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
        }
        
        selectedImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(backgroundView).inset(Constants.horizontalMargin)
            $0.width.height.equalTo(60)
            $0.centerY.equalTo(backgroundView)
        }
        
        selectedTitleLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(backgroundView).inset(Constants.horizontalMargin)
            $0.leading.equalTo(selectedImageView.snp.trailing).inset(-Constants.verticalMargin)
        }
        
        selectedprogressView.snp.makeConstraints {
            $0.top.equalTo(selectedTitleLabel.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(selectedImageView.snp.trailing).inset(-Constants.horizontalMargin)
            $0.trailing.equalTo(backgroundView).inset(Constants.horizontalMargin)
            $0.height.equalTo(4)
        }
        
        selectedIntervalLabel.snp.makeConstraints {
            $0.top.equalTo(selectedprogressView.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(selectedImageView.snp.trailing).inset(-Constants.horizontalMargin)
            $0.trailing.equalTo(backgroundView).inset(Constants.horizontalMargin)
            $0.bottom.equalTo(backgroundView).inset(Constants.verticalMargin)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
        }
        
        detailCollectionView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        modifiedButton.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        completedButton.snp.makeConstraints {
            $0.height.equalTo(60)
        }
    }
    
//    private func configureParts() {
//        selectedTitleLabel.text = selectedParts?.0
//        selectedIntervalLabel.text = selectedParts?.1.currentTime
//        selectedImageView.image = selectedIcon
//        selectedIntervalLabel.text = selectedInterval
//        selectedprogressView.progress = Float(selectedProgress ?? 0.0)
//    }
//
//    private func configureInsurance() {
//        selectedTitleLabel.text = selectedInsurance?.0
//        selectedIntervalLabel.text = selectedInsurance?.1.currentTime
//        selectedImageView.image = selectedIcon
//    }
    
    private func configureUI() {
        selectedTitleLabel.text = selectedParts?.name.rawValue
        selectedIntervalLabel.text = selectedInterval
        selectedImageView.image = selectedIcon
        selectedprogressView.progress = Float(selectedProgress ?? 0.0)
    }
    
    private func configureNewUI() {
        if let newParts = saveData?.parts.first(where: { $0.name == selectedParts?.name }) {
            var firstInterval = Util.util.toInterval(seletedDate: newParts.currentTimeToMonth!).toString()
            var secondInterval = Util.util.toInterval(seletedDate: newParts.currentTimeToMonth ?? 0, type: newParts.name).toString()
            var progress = Util.util.calculatorProgress(firstInterval: firstInterval, secondInterval: secondInterval)
            self.selectedTitleLabel.text = newParts.name.rawValue
            self.selectedIntervalLabel.text = "\(firstInterval) ~ \(secondInterval)"
            self.selectedprogressView.progress = Float(progress ?? 0.0)
        }
    }
    
    private func setCollectionView() {
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    
    private func addButtonActions() {
        modifiedButton.addAction(UIAction(handler: { _ in
            self.modifiedButtonTapped()
        }), for: .touchUpInside)
        completedButton.addAction(UIAction(handler: { _ in
            self.completedButtonTapped()
        }), for: .touchUpInside)
    }
    
    private func modifiedButtonTapped() {
        setupDatePicker()
        setupTextField()
        setupToolBar()
    }
    
    private func completedButtonTapped() {
        showAlert()
    }
    
    private func loadCarParts() {
        FirestoreService.firestoreService.loadCarPart{ data in
            DispatchQueue.main.async {
                if let data = data {
                    self.saveData = data
                }
            }
        }
    }
    
    private func setupTextField() {
        view.addSubview(textField)
        textField.frame = CGRect(x: 50, y: view.frame.size.height - 250, width: view.frame.size.width - 100, height: 50)
    }
    
    private func setupDatePicker() {
        // UIDatePicker 객체 생성을 해줍니다.
        let datePicker = UIDatePicker()
        // datePickerModed에는 time, date, dateAndTime, countDownTimer가 존재합니다.
        datePicker.datePickerMode = .date
        // datePicker 스타일을 설정합니다. wheels, inline, compact, automatic이 존재합니다.
        datePicker.preferredDatePickerStyle = .wheels
        // 원하는 언어로 지역 설정도 가능합니다.
        datePicker.locale = Locale(identifier: "ko-KR")
        // 값이 변할 때마다 동작을 설정해 줌
        datePicker.addAction(UIAction(handler: { _ in
            self.dateChange(datePicker)
        }), for: .valueChanged)
        // textField의 inputView가 nil이라면 기본 할당은 키보드입니다.
        textField.inputView = datePicker
        // textField에 오늘 날짜로 표시되게 설정
        textField.text = dateFormat(date: Date())
    }
    
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        return formatter.string(from: date)
    }
    
    private func setupToolBar() {
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "교체 완료 하셨나요?", message: "", preferredStyle: .alert)
        let sucess = UIAlertAction(title: "확인", style: .default) { _ in
            for i in 0...(self.saveData?.parts.count ?? 0) - 1 {
                if self.saveData?.parts[i].name == self.selectedParts?.name {
                    self.saveData?.parts[i].currentTime = "최근"
                }
            }
            FirestoreService.firestoreService.saveCarPart(carPart: self.saveData ?? CarPart(parts: [])) { error in
                print("carPart 저장 실패")
            }
            self.configureNewUI()
        }
        let cancel = UIAlertAction(title: "취소", style: .destructive) { _ in
            print("취소 버튼이 눌렸습니다.")
        }
        alert.addAction(sucess)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    // 값이 변할 때 마다 동작
    @objc func dateChange(_ sender: UIDatePicker) {
        textField.text = dateFormat(date: sender.date)
    }
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        //        textField.text = dateFormat(date: datePicker.date)
        textField.resignFirstResponder()
    }
}

extension MyCarDetailPageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if selectedInsurance?.0 == nil {
//            return selectedParts?.1.fixHistory.count ?? 0
//        } else {
//            return selectedInsurance?.1.fixHistory.count ?? 0
//        }
        return selectedParts?.fixHistory.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCarDetialViewCell.identifier, for: indexPath) as? MyCarDetialViewCell else { return UICollectionViewCell() }
//        if selectedInsurance?.0 == nil {
//            cell.bind(date: selectedParts?.1.fixHistory[indexPath.row]?.changedDate?.toString() ?? "", type: selectedParts?.1.fixHistory[indexPath.row]?.changedType?.rawValue ?? "")
//        } else {
//            cell.bind(date: selectedInsurance?.1.fixHistory[indexPath.row]?.changedDate?.toString() ?? "", type: selectedInsurance?.1.fixHistory[indexPath.row]?.changedType?.rawValue ?? "")
//        }
        cell.bind(date: selectedParts?.fixHistory[indexPath.row]?.changedDate?.toString() ?? "", type: selectedParts?.fixHistory[indexPath.row]?.changedType?.rawValue ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width - Constants.horizontalMargin * 2, height: 50)
    }
}
