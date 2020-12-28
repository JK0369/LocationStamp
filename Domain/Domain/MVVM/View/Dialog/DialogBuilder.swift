//
//  DialogBuilder.swift
//  AlertExample
//
//  Created by 김종권 on 2020/11/29.
//

import Foundation
import UIKit

class DialogBuilder {
    static private func dialog(title: String?, description: String?, titleBtnCancel: String?, titleBtnConfirm: String?) -> DialogVC {
        let storyboard = UIStoryboard(name: DialogVC.storyboardName, bundle: Bundle.main)
        let dialogVC = storyboard.instantiateViewController(identifier: DialogVC.storyboardID) as! DialogVC

        dialogVC.dataTitleAndDescription = (title, description)
        dialogVC.dataBtnCancelAndConfirm = (titleBtnCancel, titleBtnConfirm)

        dialogVC.modalPresentationStyle = .overCurrentContext
        dialogVC.modalTransitionStyle = .crossDissolve
        return dialogVC
    }
}

extension DialogBuilder {

    static func showErrorMessageDialog(_ data: ErrorData) -> DialogVC {
        return dialog(
            title: data.title,
            description: data.message,
            titleBtnCancel: nil,
            titleBtnConfirm: "확인"
        )
    }

    static func serverErrorDialog() -> DialogVC {
        return DialogBuilder.dialog(
            title: "네트워크 오류",
            description: "모바일 데이터 또는 Wi-Fi연결 상태를 확인후 다시 시도해 주세요",
            titleBtnCancel: nil,
            titleBtnConfirm: "확인"
        )
    }
}
