//
//  BBEnum.swift
//  BBOrm
//
//  Created by Benjamin Bourasseau on 06/03/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation

public enum Method: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

public enum Functionality: String {
    case GET, GETALL, CREATE, UPDATE, DELETE
}