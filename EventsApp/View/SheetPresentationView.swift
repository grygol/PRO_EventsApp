//
//  SheetPresentationView.swift
//  EventsApp
//
//  Created by Michał Grygolec on 30/11/2022.
//

import UIKit
import SwiftUI

struct SheetPresentationView<Content> : UIViewRepresentable where Content: View {
    @Binding var isPresented: Bool
    let content: Content
    
    func makeUIView(context: Self.Context) -> UIView {
        UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let vc = UIViewController() //UIKit View który wyświetla się w SwiftUI
        let host = UIHostingController(rootView: content) //do trzymania widoków SwiftUI wewnątrz widoku UIKit
        
        vc.addChild(host)
        vc.view.addSubview(host.view)
        
        host.view.translatesAutoresizingMaskIntoConstraints = false
        host.view.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
        host.view.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
        host.view.topAnchor.constraint(equalTo: vc.view.topAnchor).isActive = true
        host.view.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
        host.didMove(toParent: vc)
        
        vc.isModalInPresentation = true
        
        if let sheet = vc.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = true
        }
        
        if isPresented {
            uiView.window?.rootViewController?.present(vc, animated: true)
        } else {
            uiView.window?.rootViewController?.dismiss(animated: true)
        }
        
    }
}

struct SheetPresentation<SwiftUIContent> : ViewModifier where SwiftUIContent: View {
    @Binding var isPresented: Bool
    var swiftUIContent: SwiftUIContent
    
    init(isPresented: Binding<Bool>, content: () -> SwiftUIContent) {
        self._isPresented = isPresented
        self.swiftUIContent = content()
    }
    
    func body(content: Content) -> some View {
        ZStack{
            SheetPresentationView(isPresented: $isPresented, content: swiftUIContent)
            content
        }
    }
}
