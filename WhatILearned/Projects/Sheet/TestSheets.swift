import SwiftUI

struct TestSheets: View {
    @State private var showHalfSheet = false
    @State private var isPresented = false

    var body: some View {
        VStack(spacing: 10) {
            halfSheetButton
            fullScreenButton
        }
    }

    var halfSheetButton: some View {
        Button("Show Half Sheet") {
            showHalfSheet = true
        }
        .sheet(isPresented: $showHalfSheet) {
            Text("Content")
                .presentationDetents([.height(200), .medium, .large])
                .presentationDragIndicator(.automatic)
        }
        .font(.title).bold()
    }

    var fullScreenButton: some View {
        Button("Present fullscreen cover!") {
            isPresented.toggle()
        }
        .fullScreenCover(isPresented: $isPresented, content: AddArticleView.init)
    }
}
