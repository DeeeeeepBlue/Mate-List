//
//  SurveyRepositoryProtocol.swift
//  Service
//
//  Created by DOYEON LEE on 2023/03/05.
//  Copyright © 2023 com.ognam. All rights reserved.
//

import Foundation

protocol SurveyRepositoryProtocol {
    func putSurveyResult(data habitCheck: HabitCheck, pid: String) -> Observable<Bool>
}
