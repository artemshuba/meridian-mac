//
//  VkApiError.swift
//  
//
//  Created by Artem Shuba on 02/04/2020.
//

import Foundation

public enum VkApiError : Error {
    case unknown
    case needValidation(String)
}
