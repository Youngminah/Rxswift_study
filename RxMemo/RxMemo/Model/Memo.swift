//
//  Memo.swift
//  RxMemo
//
//  Created by meng on 2021/10/03.
//

import Foundation
import RxDataSources //테이블 뷰와 컬렉션 뷰에 바인딩할수 있는 데이터 소스 제공, 반드시 identifiable 프로토콜을 채용해야함

struct Memo: Equatable, IdentifiableType {
    var content: String
    var insertDate: Date
    var identity: String
    
    init(content: String, insertDate: Date = Date()){
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    
    init(original: Memo, updatedContent: String){
        self = original
        self.content = updatedContent
    }
}
