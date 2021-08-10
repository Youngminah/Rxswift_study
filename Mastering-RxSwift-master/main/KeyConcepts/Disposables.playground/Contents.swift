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
 # Disposables
 */
// Disposed는 옵져버블이 전달하는 이벤트는 아니다.
// 파라미터로 클로저를 전달하면 옵저버와 관련된 모든 리소스가 전달된 이후에 호출된다.

// 첫번째 코드
let subscription1 = Observable.from([1, 2, 3])
    .subscribe(onNext: { elem in
        print("Next", elem)
    }, onError: { error in
        print("Error", error)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: {
        print("Disposed")
    })

subscription1.dispose() //이렇게 해지해도되지만 공식문서에 dispose bag을 이용하는 것을 권장.
//그리고 만약 해지 안되더라도 자동으로 해지됨. 하지만 공식문서에 해주라고 나와있음.
 

var bag = DisposeBag()
Observable.from([1, 2, 3])
    .subscribe{
        print($0)
    } //여기까지만해도 디스포스드가 실행안되는 것이 아니다. 자동으로 리소스들이 해지됨.
    .disposed(by: bag)


bag = DisposeBag() //그냥 이렇게 새로운 DisposeBag을 만들면 이전께 해지됨.


//1초마다 1씩 증가해서 방출한다. 방출을 멈출 코드가 필요함.
let subscription2 = Observable<Int>.interval(.seconds(1),
                                             scheduler: MainScheduler.instance)
    .subscribe(onNext: { elem in
        print("Next", elem)
    }, onError: { error in
        print("Error", error)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: {
        print("Disposed")
    })
    //.disposed(by: bag)

// 3초뒤에 모든 리소스 해지시키기
DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    subscription2.dispose()
    //bag = DisposeBag()
}
//completed메소드가 호출 안됨을 볼 수 있음.
//이러한 이유러 dispose로 리소스를 해지하는 것은 피하는 것이 좋다.



//이 경우 Disposed 출력문이 없지만, 리소스가 해지됨. Completed거나 Error면 자동으로 해지됨.
// 두번째 코드
Observable.from([1, 2, 3])
    .subscribe {
        print( $0 )
    }



//: - 왜 ? Disposed가 출력되지 않았을까?
//: - Disposed는 옵져버블이 전달하는 이벤트가 아니다.
//: - 첫번째 코드처럼 작성을 한다면, 리소스가 해지되는 시점에 자동으로 호출되는 것일 뿐이다.
//: </br>
//: - Completed거나 Error면 자동으로 리소스가 정리된다.
//: - 하지만, 공식문서에 따라면 가능하면 직접 정리하라고 나와있음.
//: - Subscription에 리턴형인 Disposable은 크게 **리소스해제**와 **실행취소**에 사용됨







