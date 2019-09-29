//
//  LectureModel.swift
//  app2okanenogakko
//
//  Created by 多田隆太郎 on 2019/09/29.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//

import Foundation

class Lecture : NSObject {
    var name:NSString
    var imageUrl:NSURL?

    init(name: String, imageUrl: NSURL?){
        self.name = name as NSString
        self.imageUrl = imageUrl
    }
}
