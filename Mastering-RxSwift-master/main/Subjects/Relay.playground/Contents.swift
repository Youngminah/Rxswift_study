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
 # Relay
 */


// Rxswift는 2가지 relay를 제공한다.
// Relay는 subject와 유사한 특징을 가지고 있고, 내부에 서브젝트를 랩핑하고있다.
// 서브젝트와의 가장큰 차이는 next이벤트만 전달받고 전달한다는 것이다.
// 그래서 서브젝트와 달리 종료되지 않는다!!
// 구독자가 dispose되기 전까지 계속 이벤트를 처리한다.
// 주로 UI이벤트 처리에 활용된다
// Relay는 RxCocoa를 통해 제공된다.

let bag = DisposeBag()

let prelay = PublishRelay<Int>() // 빈생성자로 생성하는것은 퍼블리쉬서브젝트와 동일


prelay.subscribe { print("1: \($0)") }
    .disposed(by: bag)

prelay.accept(1)


let brelay = BehaviorRelay(value: 1)
brelay.accept(2)

brelay.subscribe { print("2: \($0)") }
    .disposed(by: bag)

brelay.accept(3)
print(brelay.value)
//behavior안의 value는 읽기 전용이고 수정은 불가능하다.
//바꾸고싶다면, accept이벤트를 통해 새로운 이벤트를 전달해야 한다.
