//
//  GetNutritionFromImageAction.swift
//  spajam-product
//
//  Created by 張翔 on 2020/10/10.
//

import Foundation
import Action
import UIKit
import RxSwift

enum GetNutritionFromImageAction: DataGatewayAction {
    static func action() -> Action<UIImage, Food> {
        return .init { input in
            guard let jpegImage = input.jpegData(compressionQuality: 1) else {
                return Observable.error(AppError.unknownError)
            }
            let base64ImageString = jpegImage.base64EncodedString()
            let body = RequestBody(file: base64ImageString)
            
            return APIClient.request(.post, path: "test", body: body, response: Food.self)
        }
    }
    
    private struct RequestBody: Codable {
        let file: String
    }
}
