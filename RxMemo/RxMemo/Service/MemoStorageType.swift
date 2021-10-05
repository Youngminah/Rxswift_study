//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by meng on 2021/10/03.
//

import Foundation
import RxSwift

protocol MemoStorageType {
    @discardableResult //작업결과가 필요없는경우를 위해서
    func createMemo(content: String) -> Observable<Memo>
    
    @discardableResult
    func memoList() -> Observable<[Memo]>
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>
    
    @discardableResult 
    func delete(memo: Memo) -> Observable<Memo>
}
