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
 # switchLatest
 */
//최근 옵저버블 방출
let bag = DisposeBag()

enum MyError: Error {
   case error
}

let a = PublishSubject<String>()
let b = PublishSubject<String>()

let source = PublishSubject<Observable<String>>()

source
    .switchLatest()
    .subscribe{ print($0) }
    .disposed(by: bag)

a.onNext("1")
b.onNext("b")

source.onNext(a) // 최신 옵저버블은 a 이다 a에 관한 이벤트만 앞으로 전달
a.onNext("2")
b.onNext("c")

source.onNext(b)
a.onNext("3")
b.onNext("d")

a.onCompleted() // 종료 안됨
b.onCompleted() // 종료 안됨
source.onCompleted() //종료 됨

a.onError(MyError.error) //최신 구독자가 아니라서 에러 이벤트 전달 안됨
b.onError(MyError.error) // 최신구독자라서 전달됨

