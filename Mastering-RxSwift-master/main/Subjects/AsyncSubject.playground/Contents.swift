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
import RxCocoa

/*:
 # AsyncSubject
 */
//이전의 서브젝트들와 이벤트를 전달하는 시점에 차이가 있다.
//AsyncSubject는 서브젝트로 completed 이벤트가 전달되기 전까지 어떠한 이벤트도 전달하지 않는다.
//completed 이벤트가 전달되면 그 시점에 가장 최근에 전달된 next이벤트를 구독자에게 전달한다.

let bag = DisposeBag()

enum MyError: Error {
   case error
}

let subject = AsyncSubject<Int>()

subject
    .subscribe{ print($0) }
    .disposed(by: bag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)


//이시점에 전달됨. 가장 마지막거가 전달된다.
//subject.onCompleted()
subject.onError(MyError.error)

//정리 : AsyncSuject는 Completed이벤트가 전달된 시점으로 가장 최근에 전달된 하나의next 이벤트를 구독자에게 전달한다.
//만약 전달된 이벤트가 없다면 그냥 completed이벤트만 전달하고 종료한다.
//에러이벤트에서는 넥스트이벤트가 전달되지 않는다.

