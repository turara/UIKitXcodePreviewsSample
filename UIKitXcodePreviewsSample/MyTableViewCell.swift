//
//  MyTableViewCell.swift
//  UIKitXcodePreviewsSample
//
//  Created by Turara on 2020/08/27.
//  Copyright © 2020 Turara. All rights reserved.
//

import UIKit

final class MyTableViewCell: UITableViewCell {
    static let reuseIdentifier = "\(MyTableViewCell.self)"
    
    func configure(with prop: CellProp) {
        textLabel?.text = prop.title
        imageView?.image = UIImage(systemName: prop.imageType.rawValue)
    }
}

#if DEBUG

import SwiftUI

struct MyTableViewCellWrapper: UIViewRepresentable {
    var prop: CellProp
    
    func makeUIView(context: Context) -> MyTableViewCell {
        MyTableViewCell(style: .default, reuseIdentifier: MyTableViewCell.reuseIdentifier)
    }
    
    func updateUIView(_ cell: MyTableViewCell, context: Context) {
        cell.configure(with: prop)
    }
}

struct MyTableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyTableViewCellWrapper(prop: ("Pencil", .pencil))
            MyTableViewCellWrapper(prop: ("Scribble", .scribble))
            MyTableViewCellWrapper(prop: ("Scissors", .scissors))
        }
        .previewLayout(.fixed(width: 320, height: 50))
    }
}


#endif
