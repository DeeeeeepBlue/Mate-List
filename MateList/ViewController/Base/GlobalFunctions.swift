//
//  GlobalFunctions.swift
//  checkMate
//
//  Created by 강민규 on 2022/08/12.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class FireStoreService : NSObject {
    static let db = Firestore.firestore()
}

