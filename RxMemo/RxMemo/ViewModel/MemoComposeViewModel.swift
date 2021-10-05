//
//  MemoComposeViewModel.swift
//  RxMemo
//
//  Created by meng on 2021/10/03.
//

import Foundation
import RxSwift
import RxCocoa
import Action

// 컴포즈 씬에서 사용
class MemoComposeViewModel: CommonViewModel {
    
    private let content: String?
    
    var initialText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }
    
    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction
    
    init(title: String, content: String? = nil, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType, saveAction: Action<String,Void>? = nil, cancelAction: CocoaAction? = nil){
        self.content = content
        self.saveAction = Action<String, Void> { input in
            if let action = saveAction {
                action.execute(input)
            }
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute(())
            }
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}

// 취소 액션과 저장액션을 파라미터로 받고 있음.
// 직접 구현해도 되지만, 처리방식이 고정됨.
// 파라미터로 받음으로써 이전화면에서 처리 방식을 동적으로 결정할 수 있다.
