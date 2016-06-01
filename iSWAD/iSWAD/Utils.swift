//
//  Utils.swift
//  iSWAD
//
//  Created by Raul Alvarez on 22/05/16.
//  Copyright © 2016 Raul Alvarez. All rights reserved.
//

import Foundation



func encryptPassword(password: String) -> String {
    let bytesFromPassword = [UInt8](password.utf8);
    var encryptedPassword = bytesFromPassword.sha512().toBase64()!;
    encryptedPassword = String(encryptedPassword.characters.map {$0 == "+" ? "-" : $0})
    encryptedPassword = String(encryptedPassword.characters.map {$0 == "/" ? "_" : $0})
    encryptedPassword = String(encryptedPassword.characters.map {$0 == "=" ? " " : $0})
    return encryptedPassword;
    
}