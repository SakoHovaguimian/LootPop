//
//  Observable+ext.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 7/24/21.
//

import RxSwift
import RxCocoa

public extension ObservableType /* Value */ {
    
    /// Latest value of the observable sequence.
    var value: Self.Element {
        
        var value: Self.Element!
        let disposeBag = DisposeBag()
        
        subscribe(onNext: { _value in
            value = _value
        })
        .disposed(by: disposeBag)
        
        return value
        
    }
    
}

//Examples

///ViewModel

    //private var _quiz = BehaviorRelay<Quiz?>(value: nil)
    //var quiz: Observable<Quiz?> {
    //    return self._quiz.asObservable()
    //}

///ViewController

    //self.viewModel.currentQuestion
    //    .skip(1)
    //    .observe(on: MainScheduler.instance)
    //    .bind {
    //
    //        self.questionTextView.text = $0?.text
    //        self.updateAnswers($0!.answers)
    //
    //    }
    //    .disposed(by: self.disposeBag)


