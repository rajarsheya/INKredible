//
//  TextRecognizer.swift
//  INKredible
//
//  Created by Arsheya Raj and Sunjil Gahatraj on 12/13/22.
//

import Foundation
import Vision
import VisionKit

final class TextRecognizer{
    let cameraScan: VNDocumentCameraScan
    init(cameraScan: VNDocumentCameraScan){
        self.cameraScan = cameraScan
    }
    private let queue = DispatchQueue(label: "scan-codes", qos: .default, attributes: [], autoreleaseFrequency: .workItem)
    func recognizeText(withCompletitionHandler completionHandler:@escaping ([String])-> Void){
        queue.async {
            let images = (0..<self.cameraScan.pageCount).compactMap({
                self.cameraScan.imageOfPage(at:$0).cgImage
            })
            let imagesandRequests = images.map({(image: $0, request: VNRecognizeTextRequest())})
            let textPerPage = imagesandRequests.map{image, request->String in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                do{
                    try handler.perform([request])
                    guard let observations = request.results as? [VNRecognizedTextObservation] else{return ""}
                    //guard let observations = request.results else{return ""}
                    return observations.compactMap({$0.topCandidates(1).first?.string}).joined(separator: "\n")
                }
                catch{
                    print(error)
                    return ""
                }
            }
            DispatchQueue.main.async {
                completionHandler(textPerPage)
            }
        }
    }
}
