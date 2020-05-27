//
//  VkThumb.swift
//  
//
//  Created by Artem Shuba on 27/05/2020.
//

import Foundation

public struct VkThumb : Codable {
    public let photo32: String?
    
    public let photo68: String?
    
    public let photo135: String?
    
    public let photo270: String?
    
    public let photo300: String?
    
    public let photo600: String?
    
    public let width: Int
    
    public let height: Int
}
