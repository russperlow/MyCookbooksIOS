//
//  ImageResourceManager.swift
//  MyCookbooks
//
//  Created by Russ Perlow on 5/1/20.
//  Copyright © 2020 Russ Perlow. All rights reserved.
//

import Foundation
import UIKit

class ImageResourceManager{
    static let sharedInstance: ImageResourceManager = {
        let instance = ImageResourceManager()
        return instance
    }()
    
    func saveImage(image: UIImage, imageTitle: String) -> Bool{
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
            
        }
        
        do{
            try data.write(to: directory.appendingPathComponent(imageTitle)!)
            return true
        }catch{
            print(error.localizedDescription)
            return false
        }
    }
    
    func getSavedImage(name: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false){
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(name).path)
        }
        return nil
    }
    
    
    
}
