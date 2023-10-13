//
//  MyCarCheckViewController.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/12.
//

import SnapKit
import UIKit

class MyCarCheckViewController: UIViewController {
    private let checkingList = [
        CheckingView(title: "엔진 오일은 언제 교체하셨나요?", firstButton: "6개월 전", secondButton: "3개월 전", thirdbutton: "1개월 전", fourthButton: "최근", fifthButton: "모르겠어요"),
        CheckingView(title: "미션 오일은 언제 교체하셨나요?", firstButton: "2년 전", secondButton: "1년 전", thirdbutton: "6개월 전", fourthButton: "최근", fifthButton: "모르겠어요"),
        CheckingView(title: "브레이크 오일은 언제 교체하셨나요?", firstButton: "2년 전", secondButton: "1년 전", thirdbutton: "6개월 전", fourthButton: "최근", fifthButton: "모르겠어요"),
        CheckingView(title: "브레이크 패드는 언제 교체하셨나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"),
        CheckingView(title: "마지막 타이어 로테이션은 언제였나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"),
        CheckingView(title: "타이어는 언제 교체하셨나요?", firstButton: "3년 전", secondButton: "2년 전", thirdbutton: "1년 전", fourthButton: "최근", fifthButton: "모르겠어요"),
        CheckingView(title: "연료 필터는 언제 교체하셨나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"),
        CheckingView(title: "와이퍼 블레이드는 언제 교체하셨나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"),
        CheckingView(title: "에어컨 필터는 언제 교체하셨나요?", firstButton: "1년 전", secondButton: "6개월 전", thirdbutton: "3개월 전", fourthButton: "최근", fifthButton: "모르겠어요"),
        CheckingView(title: "보험 가입 시기는 언제쯤인가요?", firstButton: "", secondButton: "", thirdbutton: "", fourthButton: "", fifthButton: ""),
    ]
//    private let checkEngineOilView = CheckingView(title: "엔진 오일은 언제 교체하셨나요?", firstButton: "6개월 전", secondButton: "3개월 전", thirdbutton: "1개월 전", fourthButton: "최근", fifthButton: "모르겠어요")
    
    private let carouselView = CarouselView()
    
    var prevIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configure()
        setupUI()
    }
    
    private func configure() {
        carouselView.collectionView.delegate = self
        carouselView.collectionView.dataSource = self
        carouselView.collectionView.prefetchDataSource = self
    }
    
    private func setupUI() {
        view.addSubview(carouselView)
        
        carouselView.snp.makeConstraints {
            $0.leading.right.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(300)
            $0.height.equalTo(600)
            $0.centerY.equalToSuperview()
        }
    }
}


extension MyCarCheckViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return checkingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselViewCell.identifier,for: indexPath) as? CarouselViewCell else { return UICollectionViewCell() }
        if indexPath.row == checkingList.count - 1 {
            collectionView.register(CustomCarouselViewCell.self, forCellWithReuseIdentifier: CustomCarouselViewCell.identifier)
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCarouselViewCell.identifier,for: indexPath) as? CustomCarouselViewCell else { return UICollectionViewCell() }
            let data = checkingList[indexPath.row].title
            cell.bind(title: data)
            return cell
        }
//        let cell = CarouselViewCell()
        let data = checkingList[indexPath.row]
        cell.bind(checkingView: data)
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemSize = CGSize(width: 300, height: 600)
        let itemSpacing: CGFloat = 30
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = itemSize.width + itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let itemSize = CGSize(width: 300, height: 600)
        let itemSpacing: CGFloat = 30
        let scrolledOffsetX = scrollView.contentOffset.x + scrollView.contentInset.left
        let cellWidth = itemSize.width + itemSpacing
        let index = round(scrolledOffsetX / cellWidth)

        let indexPath = IndexPath(item: Int(index), section: 0)
        
        if let cell = carouselView.collectionView.cellForItem(at: indexPath) {
            zoomFocusCell(cell: cell, isFocus: true)
        }
        if Int(index) != prevIndex {
            let preIndexPath = IndexPath(item: Int(index) - 1, section: 0)
            if let preCell = carouselView.collectionView.cellForItem(at: preIndexPath) {
                zoomFocusCell(cell: preCell, isFocus: false)
            }
            let nextIndexPath = IndexPath(item: Int(index) + 1, section: 0)
            if let nextCell = carouselView.collectionView.cellForItem(at: nextIndexPath) {
                zoomFocusCell(cell: nextCell, isFocus: false)
            }
            prevIndex = indexPath.item
        }
    }
    
    private func zoomFocusCell(cell: UICollectionViewCell, isFocus: Bool ) {
         UIView.animate( withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
             if isFocus {
                 cell.transform = .identity
             } else {
                 cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
             }
         }, completion: nil)
     }
}

extension MyCarCheckViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            print("indexPath: \(indexPath)")
//            viewModel.prefetchImage()
//        }
    }
}
