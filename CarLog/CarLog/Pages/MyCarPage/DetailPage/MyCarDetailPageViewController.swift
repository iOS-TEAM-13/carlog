//
//  MyCarPageDetailViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/18.
//

import UIKit

import SnapKit
import SwiftUI

class MyCarDetailPageViewController: UIViewController {
    // MARK: Properties

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .buttonSkyBlueColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var selectedTitleLabel: UILabel = {
        var label = UILabel()
        label.customLabel(text: "이름", textColor: .black, font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), alignment: .left)
        return label
    }()
    
    private lazy var selectedprogressView: UIProgressView = {
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
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [modifiedButton, completedButton])
        view.customStackView(spacing: Constants.horizontalMargin * 2, axis: .horizontal, alignment: .fill)
        view.distribution = .fillEqually
        return view
    }()
    
    private let modifiedButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "날짜 변경", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), titleColor: .white, backgroundColor: .mainNavyColor)
        return button
    }()
    
    private let completedButton: UIButton = {
        let button = UIButton()
        button.customButton(text: "점검 완료", font: UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .bold), titleColor: .white, backgroundColor: .mainNavyColor)
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
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.register(MyCarDetialViewCell.self, forCellWithReuseIdentifier: MyCarDetialViewCell.identifier)
        return view
    }()
    
    // MARK: Data

    var selectedParts: PartsInfo?
    var selectedProgress: Double?
    var selectedInterval: String?
    var selectedIcon: UIImage?
    
    var saveData = Constants.carParts
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loadCarParts()
        setupUI()
        configureUI()
        setCollectionView()
        addButtonActions()
        
        NotificationCenter.default.addObserver(self, selector: #selector(completedModified), name: Notification.Name("completedModified"), object: nil)
    }
    
    // MARK: Method

    private func loadCarParts() {
        FirestoreService.firestoreService.loadCarPart { data in
            if let data = data {
                self.saveData = data
                self.detailCollectionView.reloadData()
            }
        }
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
    
    private func configureUI() {
        let firstInterval = Util.util.toInterval(seletedDate: selectedParts?.currentTimeToMonth! ?? 0).toString()
        let secondInterval = Util.util.toInterval(seletedDate: selectedParts?.currentTimeToMonth ?? 0, type: selectedParts!.name).toString()
        let progress = Util.util.calculatorProgress(firstInterval: firstInterval, secondInterval: secondInterval)
        selectedImageView.image = selectedIcon
        selectedTitleLabel.text = selectedParts!.name.rawValue
        selectedIntervalLabel.text = "\(firstInterval) ~ \(secondInterval)"
        selectedprogressView.progress = Float(progress)
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
        let vc = ModifiedDatePickerViewController()
        vc.onDateSelected = { date in
            self.addHistory(date: Date(), currentTime: date, type: .isModifiedDate)
        }
        present(vc, animated: true)
    }
    
    private func completedButtonTapped() {
        showAlert()
    }
    
    private func updateSelectParts() {
        for i in 0...saveData.parts.count - 1 {
            if saveData.parts[i].name == selectedParts?.name {
                selectedParts = saveData.parts[i]
            }
        }
    }
    
    private func saveCarParts() {
        FirestoreService.firestoreService.saveCarPart(carPart: saveData) { error in
            print("error : \(String(describing: error))")
        }
    }
    
    private func addHistory(date: Date, currentTime: String, type: ChangedType) {
        for i in 0...(saveData.parts.count) - 1 {
            if saveData.parts[i].name == selectedParts?.name {
                saveData.parts[i].currentTime = currentTime
                saveData.parts[i].fixHistory.insert(FixHistory(changedDate: date, newDate: currentTime, changedType: type), at: 0)
            }
        }
        saveCarParts()
        updateSelectParts()
        configureUI()
        NotificationCenter.default.post(name: Notification.Name("completedModified"), object: nil)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "교체 완료 하셨나요?", message: "", preferredStyle: .alert)
        let sucess = UIAlertAction(title: "확인", style: .default) { _ in
            self.addHistory(date: Date(), currentTime: Date().toString(), type: .isFixedParts)
        }
        let cancel = UIAlertAction(title: "취소", style: .destructive) { _ in
            print("취소 버튼이 눌렸습니다.")
        }
        alert.addAction(sucess)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    // MARK: @Objc

    @objc func completedModified() {
        loadCarParts()
    }
}

// MARK: Extension

extension MyCarDetailPageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedParts?.fixHistory.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCarDetialViewCell.identifier, for: indexPath) as? MyCarDetialViewCell else { return UICollectionViewCell() }
//        cell.bind(date: selectedParts?.fixHistory[indexPath.row]?.changedDate?.toString() ?? "", type: selectedParts?.fixHistory[indexPath.row]?.changedType?.rawValue ?? "")
        cell.bind(date: selectedParts?.fixHistory[indexPath.row]?.changedDate?.toString() ?? "", newDate: selectedParts?.fixHistory[indexPath.row]?.newDate ?? "", type: selectedParts?.fixHistory[indexPath.row]?.changedType?.rawValue ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width - Constants.horizontalMargin * 2, height: 70)
    }
}
