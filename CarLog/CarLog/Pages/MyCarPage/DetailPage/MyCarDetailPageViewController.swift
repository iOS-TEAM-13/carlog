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
    
    private lazy var myCarDetailPageView = MyCarDetailPageView()
    private lazy var myCarDetailButtonStackView = HorizontalButtonStackView(firstButtonText: "날짜 변경", secondButtonText: "수정 완료")
    private lazy var myCarDetailPageCollectionView = MyCarDetailPageCollectionView()
    
    // MARK: Data

    var selectedParts: PartsInfo? {
        didSet {
            if let start = selectedParts?.startTime, let end = selectedParts?.endTime {
                selectedProgress = Util.util.calculatorProgress(firstInterval: start, secondInterval: end)
            }
        }
    }
    var selectedProgress: Double?
    var selectedIcon: UIImage?
    
    var saveData = Constants.carParts
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundCoustomColor
        
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
                self.myCarDetailPageCollectionView.detailCollectionView.reloadData()
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(myCarDetailPageView)
        view.addSubview(myCarDetailButtonStackView)
        view.addSubview(myCarDetailPageCollectionView)
        
        myCarDetailPageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.horizontalMargin)
        }
        
        myCarDetailButtonStackView.snp.makeConstraints {
            $0.top.equalTo(myCarDetailPageView.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
        }
        
        myCarDetailPageCollectionView.snp.makeConstraints {
            $0.top.equalTo(myCarDetailButtonStackView.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        guard let start = selectedParts?.startTime, let end = selectedParts?.endTime else { return }
        let progress = Util.util.calculatorProgress(firstInterval: selectedParts?.startTime ?? Date(), secondInterval: selectedParts?.endTime ?? Date())
        myCarDetailPageView.selectedImageView.image = selectedIcon
        myCarDetailPageView.selectedTitleLabel.text = selectedParts!.name.rawValue
        myCarDetailPageView.selectedIntervalLabel.text = "\(start.toString()) ~ \(end.toString())"
        myCarDetailPageView.selectedprogressView.progress = Float(progress)
    }
    
    private func setCollectionView() {
        myCarDetailPageCollectionView.detailCollectionView.delegate = self
        myCarDetailPageCollectionView.detailCollectionView.dataSource = self
    }
    
    private func addButtonActions() {
        myCarDetailButtonStackView.firstButton.addAction(UIAction(handler: { _ in
            self.modifiedButtonTapped()
        }), for: .touchUpInside)
        myCarDetailButtonStackView.secondButton.addAction(UIAction(handler: { _ in
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
        self.showAlert(checkText: "교체 완료 하셨나요?") {
            self.addHistory(date: Date(), currentTime: Date(), type: .isFixedParts)
        }
//        showAlert()
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
    
    private func addHistory(date: Date, currentTime: Date, type: ChangedType) {
        for i in 0...(saveData.parts.count) - 1 {
            if saveData.parts[i].name == selectedParts?.name {
                saveData.parts[i].currentTime = currentTime.toStringDetail()
                saveData.parts[i].fixHistory.insert(FixHistory(changedDate: date, newDate: currentTime, changedType: type), at: 0)
                NotificationService.service.pushNotification(part: saveData.parts[i])
            }
        }
        NotificationCenter.default.post(name: Notification.Name("completedModified"), object: nil)
    }
    
//    private func showAlert() {
//        let alert = UIAlertController(title: "교체 완료 하셨나요?", message: "", preferredStyle: .alert)
//        let sucess = UIAlertAction(title: "확인", style: .default) { _ in
//            self.addHistory(date: Date(), currentTime: Date(), type: .isFixedParts)
//        }
//        let cancel = UIAlertAction(title: "취소", style: .destructive) { _ in
//            print("취소 버튼이 눌렸습니다.")
//        }
//        alert.addAction(sucess)
//        alert.addAction(cancel)
//        present(alert, animated: true)
//    }
    
    // MARK: @Objc

    @objc func completedModified() {
        saveCarParts()
        loadCarParts()
        updateSelectParts()
        configureUI()
    }
}

// MARK: Extension

extension MyCarDetailPageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedParts?.fixHistory.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCarDetialViewCell.identifier, for: indexPath) as? MyCarDetialViewCell else { return UICollectionViewCell() }
        cell.bind(date: selectedParts?.fixHistory[indexPath.row]?.changedDate?.toString() ?? "", newDate: selectedParts?.fixHistory[indexPath.row]?.newDate?.toString() ?? "", type: selectedParts?.fixHistory[indexPath.row]?.changedType?.rawValue ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width - Constants.horizontalMargin * 2, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}
