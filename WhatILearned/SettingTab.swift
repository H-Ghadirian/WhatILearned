//
//  SettingTab.swift
//  WhatILearned
//
//  Created by Ghadirian, Hamed, HSE DE on 04.08.23.
//

import SwiftUI

struct SettingTab: View {
    @AppStorage("systemThemeVal") private var systemTheme: Int = SchemeType.allCases.first!.rawValue
    @State private var showingFirst = false
    @State private var showingSecond = false
    @State private var isPresented = false
    @State private var showHalfSheet = false

    enum Sheet: String, Identifiable {
        case addArticle, hapticTest, asyncAwaitRequest
        var id: String { rawValue }
    }

    @State var presentedSheet: Sheet?

    var selectedScheme: ColorScheme? {
        guard let theme = SchemeType(rawValue: systemTheme) else { return nil }
        switch theme {
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return nil
        }
    }

    var body: some View {
        VStack {
            Picker(selection: $systemTheme) {
                ForEach(SchemeType.allCases) { item in
                    Text(item.title)
                        .tag(item.rawValue)
                }
            } label: {
                Text("Pick a mode")
            }

            Text(LocalizedStringKey("Welcome"))

            Button("Show Half Sheet") {
                showHalfSheet = true
            }
            .sheet(isPresented: $showHalfSheet) {
                Text("Content")
                    .presentationDetents([.height(200), .medium, .large])
                    .presentationDragIndicator(.automatic)
            }
            .font(.title).bold()

            Button("Present fullscreen cover!") {
                isPresented.toggle()
            }
            .fullScreenCover(isPresented: $isPresented, content: FullScreenModalView.init)

            Text("This app is all about what I learned!")
            Text("You can find the code on")
            Link(
                "Source Code(Github)",
                destination: URL(
                    string: "https://github.com/H-Ghadirian/What-I-Learned"
                )!
            )
            listOfButtonToPresentSheet
            buttonToPresentSheet
        }
        .padding()
        .tabItem {
            Image(systemName: "gear")
            Text("Setting")
        }
        .tag(2)
        .preferredColorScheme(selectedScheme)
    }

    var listOfButtonToPresentSheet: some View {
        VStack {
            Button("Add Article") {
                presentedSheet = .addArticle
            }
            Button("Test Haptic") {
                presentedSheet = .hapticTest
            }
            Button("Article Category") {
                presentedSheet = .asyncAwaitRequest
            }
        }
        .sheet(item: $presentedSheet, content: { sheet in
            switch sheet {
            case .addArticle:
                ToastViewExample()
//                AddArticleView()
            case .hapticTest:
                HapticTestView()
            case .asyncAwaitRequest:
                AsyncAwaitRequest()
            }
        })
        .padding()
        .frame(width: 400, height: 300)
    }

    var buttonToPresentSheet: some View {
        VStack {
            Button("Show First Sheet") {
                showingFirst = true
            }
        }
        .sheet(isPresented: $showingFirst) {
            Button("Show Second Sheet") {
                showingSecond = true
            }
            .sheet(isPresented: $showingSecond) {
                AddArticleView()
            }
        }
    }
}

struct FullScreenModalView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.primary.edgesIgnoringSafeArea(.all)
            Button("Dismiss Modal") {
                dismiss()
            }
        }
    }
}
