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
 # merge
 */

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let oddNumbers = BehaviorSubject(value: 1)
let evenNumbers = BehaviorSubject(value: 2)
let negativeNumbers = BehaviorSubject(value: -1)

//concat과 혼동하지 않기 동작방식이 다르다.
//concat은 하나의 옵저버블이 completed된다음에 이어지는 옵저버블 방출.
//merge는 두개이상의 옵저버블을 연결하여 하나의 옵저버블로 합쳐진다음 순서대로 방출한다.

let source = Observable.of(oddNumbers, evenNumbers, negativeNumbers)

source
    //.merge()
    .merge(maxConcurrent: 2)
    .subscribe{ print($0) }
    .disposed(by: bag)


oddNumbers.onNext(3)
evenNumbers.onNext(4)
evenNumbers.onNext(6)
oddNumbers.onNext(5)

//oddNumbers.onCompleted() // odd는 이제 새로운 이벤트 전달 불가능 even은가능
oddNumbers.onError(MyError.error)// 하나라도 에러라면 그 즉시 중단되고 다음 이벤트는 받지 않는다.
evenNumbers.onNext(8)
evenNumbers.onCompleted()

//둘다 종료해야 종료된다.

