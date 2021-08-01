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

//연산자가 무엇인지에 대해서만 소개
/*:
 # Operators
 */

let bag = DisposeBag()

// - 연산자는 보통 subscribe 메소드 앞에 위치한다.
// - 그래야 subscribe에서 우리가 원하는 최종 값 방출 가능
Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9])
    .take(5) //처음 다섯개만 방출
    .filter{ $0.isMultiple(of: 2) } //짝수만 전달 (isMultiple배수인지 확인)
    .subscribe { print($0) }
    .disposed(by: bag)


// - 연산자는 새로운 옵저버블을 리턴하기 때문에,
// - 두 개이상의 연산자를 연달아 호출 할 수 있다.
// - 하지만 호출 순서에 따라 다른 결과가 나오기 때문에 호출 순서를 항상 주의해야 한다.





















