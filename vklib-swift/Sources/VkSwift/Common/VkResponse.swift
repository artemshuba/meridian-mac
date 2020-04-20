//
//  VkResponse.swift
//  
//
//  Created by Artem Shuba on 02/04/2020.
//

import Foundation

struct VkResponse<T> : Codable where T: Codable {
    let response: T
}
