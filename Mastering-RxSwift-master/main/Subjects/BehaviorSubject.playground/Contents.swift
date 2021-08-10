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
 # BehaviorSubject
 */

//PublishSubject와 비슷한 방식으로 사용됨
//생성방식에서 차이가 있다.


let disposeBag = DisposeBag()

enum MyError: Error {
   case error
}

//생성에서 둘의 차이를 알아보기
let p = PublishSubject<Int>()
let b = BehaviorSubject<Int>(value: 0)


//구독에서의 차이점 알아보기
p.subscribe { print("PublishSubject >>", $0) }
    .disposed(by: disposeBag)

b.subscribe { print("BehaviorSubject >>", $0) }
    .disposed(by: disposeBag)


//BehaviorSubject를 생성하면, 내부에 next이벤트가 하나 생성된다.
//여기에는 생성자로 저장한 값이 전달된다.
//새로운 구독자가 추가되면 저장되어있던 넥스트이벤트가 바로 전달된다.

b.onNext(1)

//만약 여기서 새로운 옵저버를 추가하면 BehaviorSubject는 어떤이벤트를 전달 할까?
b.subscribe { print("BehaviorSubject2 >>", $0) }
    .disposed(by: disposeBag)

//b.onCompleted()
b.onError(MyError.error)


b.subscribe { print("BehaviorSubject3 >>", $0) }
    .disposed(by: disposeBag)

//BehaviorSubject는 새로운 넥스트 이벤트가 생기면 기존에 있던 이벤트를 교체하는 방식
//결과적으로 가장 최신 이벤트를 옵저버에게 전달함.
