//
//  DetailCoordinator.swift
//  MateList
//
//  Created by 강민규 on 2023/01/06.
//

import Utility
import Service

public protocol DetailCoordinator: Coordinator {
    func start(with postData: Post?)

}
