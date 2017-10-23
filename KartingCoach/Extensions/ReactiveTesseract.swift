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
                _ = self.base
                if let tesseract = $0 {
                    print(tesseract.recognizedText)
                    observer.send(value: tesseract)
                }
                observer.sendCompleted()
            }
            recognizeQueue.addOperation(self.base)
        }
    }
}
