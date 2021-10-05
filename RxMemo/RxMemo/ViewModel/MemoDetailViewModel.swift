//
//  MemoDetailViewModel.swift
//  RxMemo
//
//  Created by meng on 2021/10/03.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoDetailViewModel: CommonViewModel {
    let memo: Memo //이전씬에서 전달된 메모가 저장됨
    
    private var formatter: DateFormatter = { //날짜를 문자열로 바꿀 때 사용된다.
        let f = DateFormatter()
        f.locale = Locale(identifier: "Ko_kr")
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()
    
    var contents: BehaviorSubject<[String]> // 편집한뒤 다시 보기로 돌아오면 편집한 내용이 보여야함 그래서 새로운 문자열을 방출할 BehaviorSubject
    
    init(memo: Memo, title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
        self.memo = memo
        contents = BehaviorSubject<[String]>(value: [
            memo.content,
            formatter.string(from: memo.insertDate)
        ])
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
    
    lazy var popAction = CocoaAction { [unowned self] in
        return self.sceneCoordinator.close(animated: true).asObservable().map { _ in }
    }
}
