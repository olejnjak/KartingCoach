//
//  ReactiveTesseract.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 23/10/2017.
//

import TesseractOCR
import ReactiveSwift

let recognizeQueue = OperationQueue()

extension Reactive where Base: G8RecognitionOperation {
    func recognizeProducer() -> SignalProducer<G8Tesseract, NoError> {
        return SignalProducer { observer, _ in
            self.base.recognitionCompleteBlock = {
                if let tesseract = $0 {
                    observer.send(value: tesseract)
                }
                observer.sendCompleted()
            }
            recognizeQueue.addOperation(self.base)
        }
    }
}
