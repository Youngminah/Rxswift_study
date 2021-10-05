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
    
    private lazy var sectionModel = MemoSectionModel(model: 0, items: list)
    
    //MARK: 이부분을 생성해서 계속 방출하는 이유는 무엇일까?
    //나중에 테이블뷰를 사용할 텐데, 이부분이 계속 방출되어야
    //테이블뷰가 바로바로 업데이트 된다.
    private lazy var store = BehaviorSubject<[MemoSectionModel]>(value: [sectionModel])
    
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        sectionModel.items.insert(memo, at: 0)
        store.onNext([sectionModel])
        return Observable.just(memo)
    }
    
    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]> {
        return store
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        if let index = sectionModel.items.firstIndex(where: { $0 == memo }){
            sectionModel.items.remove(at: index)
            sectionModel.items.insert(updated, at: index)
        }
        store.onNext([sectionModel])
        return Observable.just(updated)
    }
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = sectionModel.items.firstIndex(where: {$0 == memo}){
            sectionModel.items.remove(at: index)
        }
        store.onNext([sectionModel])
        return Observable.just(memo)
    }
}
