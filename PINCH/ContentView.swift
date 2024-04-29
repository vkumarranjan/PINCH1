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
                Color.clear
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
                
                // MARK: Magnification
                
                    .gesture(
                     MagnificationGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                if imageSacle >= 1 && imageSacle <= 5 {
                                    imageSacle = value
                                } else if imageSacle > 5 {
                                    imageSacle = 5
                                }
                            }
                            
                        }
                        .onEnded { _ in
                            if imageSacle > 5  {
                                imageSacle = 5
                            } else if imageSacle <= 1 {
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
            
            // MARk infor panel
            .overlay(
               InfoPanelView(scale: imageSacle, offset: imagOffset)
                .padding(.horizontal)
                .padding(.top, 30)
               , alignment: .top
            )
            // Controlles
            
            .overlay(
            
                Group {
                    HStack {
                        // Scale up
                        Button {
                            withAnimation(.spring()) {
                                if imageSacle > 1 {
                                    imageSacle -= 1
                                    
                                    if imageSacle <= 1 {
                                        resetImageScale()
                                    }
                                }
                            }
                        } label : {
                            Image(systemName: "minus.magnifyingglass")
                                .font(.system(size: 36))
                        }
                        // Reset
                        
                        Button {
                            resetImageScale()
                            
                        } label : {
                            Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                                .font(.system(size: 36))
                        }
                        
                        // Sacle down
                        Button {
                            
                            withAnimation(.spring()) {
                                if imageSacle < 5 {
                                    imageSacle += 1
                                    
                                    if imageSacle > 5 {
                                        imageSacle = 5
                                    }
                                }
                            }
                            
                        } label : {
                            Image(systemName: "plus.magnifyingglass")
                                .font(.system(size: 36))
                        }
                        
                        
                    } //: Controlls
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimation ? 1 : 0)
                }
                    .padding(.bottom, 30)
                ,alignment: .bottom
            )
            
        } // : NAvigation
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
