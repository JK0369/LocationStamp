//
//  ImageFileManager.swift
//  Domain
//
//  Created by 김종권 on 2021/01/02.
//

import UIKit

class ImageFileManager {
    static let shared: ImageFileManager = ImageFileManager()
    private init() {}

    func saveImage(image: UIImage, name: String,
                   onSuccess: @escaping ((Bool) -> Void)) {
        guard let data: Data
                = image.jpegData(compressionQuality: 1)
                ?? image.pngData() else { return }
        if let directory: NSURL =
            try? FileManager.default.url(for: .documentDirectory,
                                         in: .userDomainMask,
                                         appropriateFor: nil,
                                         create: false) as NSURL {
            do {
                try data.write(to: directory.appendingPathComponent(name)!)
                onSuccess(true)
            } catch let error as NSError {
                print("Could not saveImage: \(error), \(error.userInfo)")
                onSuccess(false)
            }
        }
    }

    func loadImage(named: String) -> UIImage? {
      if let dir: URL
        = try? FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false) {
        let path: String
          = URL(fileURLWithPath: dir.absoluteString)
              .appendingPathComponent(named).path
        let image: UIImage? = UIImage(contentsOfFile: path)

        return image
      }
      return nil
    }
}

    // use saveImage()
//    let uniqueFileName: String
//      = "(ProcessInfo.processInfo.globallyUniqueString).jpeg"
//    ImageFileManager.shared
//      .saveImage(image: image,
//                 name: uniqueFileName) { [weak self] onSuccess in
//      print("saveImage onSuccess: \(onSuccess)")
//    }


    // use getSavedImage
//if let image: UIImage
//  = ImageFileManager.shared.loadImage(named: "fileName") {
//  imageView.image = image
//}

