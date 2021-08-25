//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift

/*:
 # flatMap
 */
//원본 옵저버블이 방출하는 값을 감시하고, 최신값을 확인할 수 있다.


let disposeBag = DisposeBag()

let a = BehaviorSubject(value: 1)
let b = BehaviorSubject(value: 2)

let subject = PublishSubject<BehaviorSubject<Int>>()

subject
    .flatMap({ $0.asObservable() })
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

subject.onNext(a)
subject.onNext(b)

a.onNext(11)
b.onNext(22)
a.onNext(13)

// 모든 옵저버블은 최종적으로 하나의 옵저버블로 합쳐지고 , 모든 항목들이 이 옵저버블을 통해서 구독자로 전달된다.
// 업데이트 되는 최신 항목들도 구독자에게 전달된다.
// 네트워크때 주로 사용된다.



