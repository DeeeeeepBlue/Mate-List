//
//  GlobalFunctions.swift
//  checkMate
//
//  Created by 강민규 on 2022/08/12.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

public class FireStoreService : NSObject {
    static public let db = Firestore.firestore()
}

