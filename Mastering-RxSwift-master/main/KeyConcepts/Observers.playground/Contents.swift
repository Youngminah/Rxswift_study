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
//에러, 컴플리트 모두 옵저버블의 라이프 사이클 중 가장 마지막에 전달된다.


Observable<Int>.create { (observer) -> Disposable in
   observer.on(.next(0))
   observer.onNext(1)
   
   observer.onCompleted()
   
   return Disposables.create()
}



Observable.from([1, 2, 3])

















