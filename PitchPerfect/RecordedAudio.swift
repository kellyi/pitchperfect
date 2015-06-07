//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Kelly Innes on 6/4/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl:NSURL!
    var title:String!

    init(path: NSURL, title: String) {
        self.filePathUrl = path
        self.title = title
    }
}
