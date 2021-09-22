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

//Rxswift의 에러처리 방법
//옵저버블이 네트워크 요청을 처리하고 구독자가 UI를 업데이트 할때는 next이벤트가 전달될때 사용.
//하지만 에러가 발생하면 next이벤트 전달이 안된다.
//해결: 1. 에러이벤트가 발생하면 새로운 옵저버블이 생성한다. 그래서 구독자에게 전달. 2. 기존 옵저버블을 다시 구독하는 방법. retry연산자 사용.

/*:
 # catchError
 */

//catchError 함수는 넥스트 이벤트나 컴플리트 이벤트는 그대로 전달.
//하지만 에러 발생 경우 새로운 값을 전달한다.
//특히나 네트워크 요청에서 많이 사용한다. 올바른 값이 전달되지 않는 상황에서 로컬캐시나 기본값을 사용할 수 있도록 할 수 있다.

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let subject = PublishSubject<Int>()
let recovery = PublishSubject<Int>()

subject
    .catchError({ _ in
        recovery
    })
   .subscribe { print($0) }
   .disposed(by: bag)

subject.onError(MyError.error)

subject.onNext(11)
recovery.onNext(22)
recovery.onCompleted()

//catchError는 소스옵저버블에서 생긴 오류를 새로운 옵저버블로 교체하는 역할을 해줌
