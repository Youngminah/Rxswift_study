//
//  TransitionModel.swift
//  RxMemo
//
//  Created by meng on 2021/10/03.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
