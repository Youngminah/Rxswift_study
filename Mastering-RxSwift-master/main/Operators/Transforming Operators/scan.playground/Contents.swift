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
 # scan
 */

let disposeBag = DisposeBag()

//스캔연산자로 전달하는 클로저는 accumulater function or closure라고 부른다.
//기본값이나 옵저버블이 방출하는 값으로 어큐뮬레이터를 실행한다음, 결과를 옵저버블로 리턴한다.
//클로저가 리턴한 값은 이어서 실행되는 클로저의 첫번째 값으로 전달된다.

Observable.range(start: 1, count: 10)
    .scan(0, accumulator: +)
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

//누적시키면서 중간결과도 확인해야하고 누적결과도 확인해야하는경우 사용한다.
