//: [Previous](@previous)

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
 # throttle
 ## latest parameter
 */

let disposeBag = DisposeBag()

func currentTimeString() -> String {
   let f = DateFormatter()
   f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
   return f.string(from: Date())
}


//Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//   .debug()
//   .take(10)
//   .throttle(.milliseconds(2500), latest: true, scheduler: MainScheduler.instance)
//   .subscribe { print(currentTimeString(), $0) }
//   .disposed(by: disposeBag)


Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//   .debug()
   .take(10)
   .throttle(.milliseconds(2500), latest: false, scheduler: MainScheduler.instance)
   .subscribe { print(currentTimeString(), $0) }
   .disposed(by: disposeBag)
 
//latest true, false 차이.
// true는 2.5초가 지나면 마지막 이벤트 방출 (엄격)
// false는 2.5초가 지난 이후에 생긴 첫 이벤트 방출 (지정된 주기 초과)
