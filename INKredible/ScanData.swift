//
//  ScanData.swift
//  INKredible
//
//  Created by Arsheya Raj and Sunjil Gahatraj on 12/13/22.
//

import Foundation

struct ScanData:Identifiable{
    var id = UUID()
    let content:String
    
    init(content:String){
        self.content = content
    }
}
