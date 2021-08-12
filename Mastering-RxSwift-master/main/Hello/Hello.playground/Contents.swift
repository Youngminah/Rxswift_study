//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>


import UIKit
import RxSwift


let disposeBag = DisposeBag()
//
//Observable.just("Hello, RxSwift")
//    .subscribe{ print($0)}
//    .disposed(by: disposeBag)


//명령형 프로그래밍
//var a = 1
//var b = 2
//
//a + b
//
//a = 12 // 이전에 있던 a + b의 결과는 바뀌지 않는다.


//Reactive 반응형 프로그래밍 : 값이나 상태변화에 따라서, 새로운 값을 도출하는 코드를 쉽게 작성 할 수 있다.
let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

Observable.combineLatest(a, b) { $0 + $1 }
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)

a.onNext(12) // 한번 더 계산이 된다. ⭐️이것이 명령형 프로그래밍과의 차이점!
























