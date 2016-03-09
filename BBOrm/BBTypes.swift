//
//  BBTypes.swift
//  BBOrm
//
//  Created by Benjamin Bourasseau on 29/01/2016.
//  Copyright © 2016 Benjamin. All rights reserved.
//

import Foundation


/* The differents type of datas properties can be */
public enum BBType: String {
    case BBTypeString = "String",BBTypeText = "Text",BBTypeInt = "Int",BBTypeFloat = "Float",BBTypeBool = "Bool",BBTypeEnum = "Enum", BBTypeDate = "Date",BBTypeTime = "Time",BBTypeDateTime = "DateTime",BBTypeFile = "File",BBTypeArray = "Array",BBTypeObject = "Object", BBTypeUnknown = "Unknown"
}