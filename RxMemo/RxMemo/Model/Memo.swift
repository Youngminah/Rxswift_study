//
//  Memo.swift
//  RxMemo
//
//  Created by meng on 2021/10/03.
//

import Foundation
import RxDataSources //테이블 뷰와 컬렉션 뷰에 바인딩할수 있는 데이터 소스 제공, 반드시 identifiable 프로토콜을 채용해야함
import CoreData
import RxCoreData

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


extension Memo: Persistable {
    public static var entityName: String {
        return "Memo"
    }

    static var primaryAttributeName: String {
        return "identity"
    }
    
    init(entity: NSManagedObject) {
        content = entity.value(forKey: "content") as! String
        insertDate = entity.value(forKey: "insertDate") as! Date
        identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }

    func update(_ entity: NSManagedObject) {
        entity.setValue(content, forKey: "content")
        entity.setValue(insertDate, forKey: "insertDate")
        entity.setValue("\(insertDate.timeIntervalSinceReferenceDate)", forKey: "identity")
        
        do { //Rxcoredata 를 사용하지 않고있음 그래서 save를 직접 구현해야함
            try entity.managedObjectContext?.save()
        } catch {
            print(error)
        }
    }
}

