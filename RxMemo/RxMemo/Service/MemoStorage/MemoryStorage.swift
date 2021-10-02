//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by meng on 2021/10/03.
//

import Foundation
import RxSwift

class MemoryStorage: MemoStorageType {
    
    private var list = [
        Memo(content: "Hello, RxSwift", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Lorem Ipsum", insertDate: Date().addingTimeInterval(-20))
    ]
    
    //MARK: 이부분을 생성해서 계속 방출하는 이유는 무엇일까?
    //나중에 테이블뷰를 사용할 텐데, 이부분이 계속 방출되어야
    //테이블뷰가 바로바로 업데이트 된다.
    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        store.onNext(list)
        return Observable.just(memo)
    }
    
    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func updateMemo(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        if let index = list.firstIndex(where: { $0 == memo }){
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        store.onNext(list)
        return Observable.just(updated)
    }
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = list.firstIndex(where: {$0 == memo}){
            list.remove(at: index)
        }
        store.onNext(list)
        return Observable.just(memo)
    }
}
