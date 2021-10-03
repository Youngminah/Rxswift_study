//
//  SceneCoordinatorType.swift
//  RxMemo
//
//  Created by meng on 2021/10/03.
//

import Foundation
import RxSwift

//이렇게 구성을하면 여기에 구독자를 추가하고 화면이동이 이루어진 후에
//원하는 작업을 수행할 수 있다.
//이러한 작업이 필요 없다면 사용하지 않아도 된다.
protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable  //새로운 씬을 표시
    
    @discardableResult
    func close(animated: Bool) -> Completable // 현재 씬을 닫고 이전씬으로 돌아간다.
}
