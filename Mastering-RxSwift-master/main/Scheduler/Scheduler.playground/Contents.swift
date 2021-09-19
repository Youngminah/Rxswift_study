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
 # Scheduler
 */
//ios 스레드가 필요할 때 GCD를 쓰는데,
//Rxswift에선 스케줄러를 쓴다.

//스케줄러는 특정 코드가 실행되는 context를 추상화한 것이다.
//context는 low Level 스레드가 될 수도 있고, 디스패치큐나 오퍼레이션 큐가 될 수도 있다.
//스케줄러는 추상화된 context이기 때문에 스레드와 1:1로 매칭되지 않는다.
//하나의 스레드에 2개이상의 개별 스케줄러가있을 수도 있고, 하나의 스케줄러가 두개의 스레드에 걸쳐있는 경우도 있다.
//큰 틀에서 보면 GCD와 유사하다.

//UI를 업데이트하는부분은 메인 스케줄러에서 실행한다.
//네트워킹요청은 백그라운드 스케줄러에서 실행된다.

//Serial Scheduler : CurrentThreadScheduler(스케줄러를 별로도 지정하지 않을때), MainScheduler(UI업데이트할때), SerialDispatchQueueScheduler
//Concurrent Scheduler : ConcurrentDispatchQueueScheduler, OperationQueueScheduler(디스패치큐가아닌 오퍼레이션큐를 이용해서 생성)
//이외에도 TestScheduler, Custom Scheduler 제공

let bag = DisposeBag()
let backgroundScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
   .filter { num -> Bool in
      print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> filter")
      return num.isMultiple(of: 2)
   }
    .observeOn(backgroundScheduler) // 이 아래부터는 다 백그라운드스레드에서 실행된다. 이어지는 연산자가 실행하는 스케줄러를 지정한다.
   .map { num -> Int in
      print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> map")
      return num * 2
   }
    .subscribeOn(MainScheduler.instance) //호출시점에 중요하지 않음. 이름에 혼동하지 않기 . 옵저버블이 시작되는 스케줄러를 지정한다.
    .observeOn(MainScheduler.instance)
   .subscribe {
      print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> subscribe")
      print($0)
   }
    .disposed(by: bag)

// observeOn과 subscribeOn의 차이를 알기!



