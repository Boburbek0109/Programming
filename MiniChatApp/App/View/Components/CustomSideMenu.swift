//
//  CustomSideMenu.swift
//  MiniChatApp
//
//  Created by Bobur Sobirjanov on 6/11/26.
//

import SwiftUI

struct CustomSideMenu<MenuContent: View, Contetn: View>: View{
    var isEnabeld = true
    var sideBarWidth: CGFloat = 280
    @Binding var isOpen: Bool
    
    @ViewBuilder var menuContent: (_ progress: CGFloat) -> MenuContent
    @ViewBuilder var contetn: (_ progress: CGFloat) -> Contetn
    
    @State private var progress : CGFloat = 0
    @State private var xOffset: CGFloat = 0
    @State private var haptics = false
    
    var body: some View{
        ZStack(alignment: .leading){
            menuContent(progress)
                .frame(width: sideBarWidth)
                .frame(maxHeight: .infinity)
                .opacity(progress)
                .scaleEffect(0.95 + (0.05 * progress))
            
            contetn(progress)
                .containerRelativeFrame(.horizontal)
                .frame(maxHeight: .infinity)
                .background{
                    backgroundShape
                        .fill(.background)
                        .ignoresSafeArea()
                }
                .overlay{
                    backgroundShape
                        .fill(.fill.tertiary)
                        .stroke(.fill.secondary, lineWidth: 1)
                        .ignoresSafeArea()
                        .contentShape(.rect)
                        .onTapGesture {
                            withAnimation(animation){
                                dismissMenu()
                            }
                        }
                        .opacity(progress)
                }
                .mask{
                    backgroundShape
                        .ignoresSafeArea()
                }
                .compositingGroup()
                .shadow(color: .black.opacity(0.06 * progress),radius: 5, x: -10, y: 0)
                .offset(x: xOffset)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(.rect)
        .gesture(
            CustomSideMenuGesture(isEnabeld: isEnabeld, isOpen: $isOpen){ gesture in
                let state = gesture.state
                let translation = gesture.translation(in: gesture.view).x + (isOpen ? sideBarWidth : 0)
                let velocity = gesture.velocity(in: gesture.view).x
                
                if state == .began || state == .changed {
                    xOffset = min(max(translation, 0), sideBarWidth)
                    progress = xOffset / sideBarWidth
                } else {
                    withAnimation(animation){
                        if ( xOffset + velocity) > (sideBarWidth / 2) {
                            expanedMenu()
                        } else {
                            dismissMenu()
                        }
                    }
                }
            }
        )
        .sensoryFeedback(.impact(weight: .light), trigger: haptics)
        .onChange(of: isOpen) { oldValue, newValue in
            withAnimation(animation) {
                if newValue && progress != 1{
                    expanedMenu()
                }
                
                if !newValue && progress != 0 {
                    dismissMenu()
                }
            }
        }
    }
    
    func expanedMenu() {
            if !isOpen { haptics.toggle()}
            // Expanded
            xOffset = sideBarWidth
            progress = 1
            isOpen = true
    }
    
    func dismissMenu() {
        if isOpen { haptics.toggle()}
        // Reset
        xOffset = 0
        progress = 0
        isOpen = false
    }
    
    var backgroundShape: some Shape {
        if #available(iOS 26, *) {
            return ConcentricRectangle(corners: .concentric, isUniform: true)
        } else {
            return RoundedRectangle(cornerRadius: 45)
        }
    }
    
    var animation: Animation {
        .interactiveSpring(duration: 0.2, extraBounce: 0.02)
    }
}


/// -  -  -  -

fileprivate struct CustomSideMenuGesture: UIGestureRecognizerRepresentable {
    var isEnabeld: Bool
    @Binding var isOpen: Bool
    var handler: (UIPanGestureRecognizer) -> ()
    
    func makeUIGestureRecognizer(context: Context) -> UIPanGestureRecognizer {
        let gesture = UIPanGestureRecognizer()
        gesture.delegate = context.coordinator
        gesture.maximumNumberOfTouches = 1
        return gesture
    }
    
    func updateUIGestureRecognizer(_ recognizer: UIPanGestureRecognizer, context: Context) {
        recognizer.isEnabled = isEnabeld
    }
    
    func handleUIGestureRecognizerAction(_ recognizer: UIPanGestureRecognizer, context: Context) {
        handler(recognizer)
    }
    
    func makeCoordinator(converter: CoordinateSpaceConverter) -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        var parent: CustomSideMenuGesture
        init(parent: CustomSideMenuGesture) {
            self.parent = parent
        }
        
        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            if let panGesture = gestureRecognizer as? UIPanGestureRecognizer {
                let velocity = panGesture.velocity(in: panGesture.view)
                let isHorizontalSwipe = abs(velocity.x) > abs(velocity.y)
                
                return (isHorizontalSwipe && velocity.x > 0) || (isHorizontalSwipe && velocity.x < 0 && parent.isOpen)
            }
            
            return false
        }
        
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            if let scrollview = otherGestureRecognizer.view as? UIScrollView {
                let offset = scrollview.contentOffset.x
                return offset <= 0
            }
            return false
        }
    }
}
