//
//  Presenter.swift
//  UIKitXcodePreviewsSample
//
//  Created by Turara on 2020/08/27.
//  Copyright © 2020 Turara. All rights reserved.
//

import Foundation

enum ImageType: String {
    case pencil
    case scissors
    case scribble
}

typealias CellProp = (title: String, imageType: ImageType)

protocol PresenterOutput: AnyObject {
    func updateData(_ data: [CellProp])
}

protocol PresenterInput {
    var data: [CellProp] { get }
    func didPushFetchButton()
}
