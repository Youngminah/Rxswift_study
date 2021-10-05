//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by meng on 2021/10/03.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoListViewModel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList
            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { row, memo, cell in
                cell.textLabel?.text = memo.content
            }
            .disposed(by: rx.disposeBag)
        
        addButton.rx.action = viewModel.makeCreateAction()
        
        //테이블 뷰에서 메모를 선택하면 뷰모델을 이용해서 디테일 액션을 전달하고,
        //선택한 셸은 선택해제
        Observable.zip(listTableView.rx.modelSelected(Memo.self), listTableView.rx.itemSelected) //이렇게 하면 선택된 메모와 인덱스패스가 튜플 형태로 방출
            .do(onNext: { [unowned self] (_, indexPath) in
                self.listTableView.deselectRow(at: indexPath, animated: true)
            })
            .map { $0.0 }
            .bind(to: viewModel.detailAction.inputs) //전달된 메모를 디테일 액션과 바인딩
            .disposed(by: rx.disposeBag)
        
        listTableView.rx.modelDeleted(Memo.self) //컨트롤 이벤트를 리턴. 컨트롤 이벤트는 메모를 삭제할 때마다 넥스트 이벤트 방출
            .bind(to: viewModel.deleteAction.inputs)
            .disposed(by: rx.disposeBag) //스와이프 딜리트가 자동 활성
    }
}
