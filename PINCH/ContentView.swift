//
//  ContentView.swift
//  PINCH
//
//  Created by vinay Kumar ranjan on 26/04/24.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    @State var isAnimation: Bool = false
    @State var imageSacle: CGFloat = 1
    @State var imagOffset: CGSize = .zero

    
    // MARK: - FUNCTION
    
    
    func resetImageScale() {
       return withAnimation(.linear(duration: 1)) {
            imageSacle = 1
            imagOffset = .zero
        }
    }
    
    // MARK: - CONTENT
    
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                // MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimation ? 1 : 0)
                    .offset(x: imagOffset.width, y: imagOffset.height)
                    .scaleEffect(imageSacle)
                    .onTapGesture(count: 2, perform: {
                        if imageSacle == 1 {
                            withAnimation(.spring()) {
                                imageSacle = 5
                            }
                        } else {
                            resetImageScale()
                        }
                    })
                        
                    //MARK: 2 Drag Gesture
                    .gesture(
                        DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                imagOffset = value.translation
                            }
                        }
                            .onEnded { _ in
                                if imageSacle <= 1 {
                                    resetImageScale()
                                }
                            }
                    )
                
            } //: ZStack
            .navigationTitle("Pinch and Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimation = true
                }
            })
            
        } // : NAvigation
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
