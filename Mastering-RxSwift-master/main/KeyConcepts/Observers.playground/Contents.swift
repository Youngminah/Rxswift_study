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
 # Observers
 */
//옵저버블에서 새로운 이벤트는 넥스트를 이용하여 옵저버한테 전달된다. (Emission 방출이라고 표현함)
//옵저버블에서 에러가나면 에러이벤트가 전달된다.
//반면, 성공적으로 전달되면 completed 이벤트가 전달된다.
//에러, 컴플릿티드 모두 옵저버블의 라이프 사이클 중 가장 마지막에 전달된다.
//에러와, 컴플릿티드는 Emission이라고 부르지 않고, Notification이라고 부른다.
//옵저버블이 전달하는 세 가지 이벤트 : next, error, completed

Observable<Int>.create { (observer) -> Disposable in
   observer.on(.next(0))
   observer.onNext(1)
   
   observer.onCompleted()
   
   return Disposables.create()
}



Observable.from([0,1])
// 위의 옵저버블이랑 같은 역할. 연속된 무엇을 전달할때는 create보단 from을 이용하는것이 좋다.


//여기까지는 옵저버블은 실행되지 않는다.
//옵저버블의 이벤트 순서를 정의했을 뿐이고,
//이벤트가 전달되는 순간은 옵저버가 옵저버블을 구독하는 순간이다.














