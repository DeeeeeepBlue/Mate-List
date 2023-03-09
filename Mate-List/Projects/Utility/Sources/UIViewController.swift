//
//  UIViewController.swift
//  Utility
//
//  Created by 강민규 on 2023/03/09.
//  Copyright © 2023 com.ognam. All rights reserved.
//

import SwiftUI

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
    }

    public func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif
