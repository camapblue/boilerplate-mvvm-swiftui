//
//  View+Extension.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 1/9/22.
//

import SwiftUI

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}

public typealias ViewModelProviderCreate<V: ObservableObject> = () -> V

// Provide ViewModel
public protocol ProvideViewModelModifierProtocol: ViewModifier {
    associatedtype V where V: ObservableObject
}

public struct ProvideViewModelModifier<V: ObservableObject>: ProvideViewModelModifierProtocol {
    let viewModel: V
    
    public init(viewModel: V) {
        self.viewModel = viewModel
    }
    
    public func body(content: Content) -> some View {
        content.environmentObject(viewModel)
    }
}

public extension View {
    @ViewBuilder
    func provideViewModel<V: ObservableObject>(create: ViewModelProviderCreate<V>) -> some View {
        let viewModel = create()
        self.modifier(
            ProvideViewModelModifier(viewModel: viewModel)
        )
    }
}

// MARK: ViewDidLoad extension

struct ViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }

}

extension View {
    func onLoaded(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}
