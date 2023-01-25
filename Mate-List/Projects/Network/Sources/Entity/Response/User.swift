//
//  User.swift
//  checkMate
//
//  Created by 강민규 on 2022/02/18.
//

import Foundation

public struct User {
    public let uid: String
    public let email: String
    public let name: String
    public let gender: String
    public let age: String
    public let habit: HabitCheck
    
    public init(uid: String, email: String, name: String, gender: String, age: String, habit: HabitCheck) {
        self.uid = uid
        self.email = email
        self.name = name
        self.gender = gender
        self.age = age
        self.habit = habit
    }
}
