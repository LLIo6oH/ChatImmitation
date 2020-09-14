//
//  DialogueView.swift
//  ChatImitation
//
//  Created by Dmitry Kuklin on 08.09.2020.
//

import SwiftUI

struct DialogueView: View {
    
    @ObservedObject var dialogViewModel = DialogueViewModel()
    @State var opacity: Double = 0
    @State var showedMessageIndex = 1
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var chatBubble: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor(Color(hex: AppDefaults.AppColors.bubbleColor))
            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 1, y: 1)
    }
    
    private func chatBubbleTriange(width: CGFloat, height: CGFloat) -> some View {
            Path { path in
              path.move(to: CGPoint(x: 0, y: height))
              path.addLine(to: CGPoint(x: width+3, y: height))
              path.addLine(to: CGPoint(x: width, y: 0))
              path.closeSubpath()
            }
            .fill(Color(hex: AppDefaults.AppColors.bubbleColor))
            .frame(width: width, height: height)
            .shadow(color: Color.black.opacity(0.5), radius: 1, x: 0, y: 1)
            .zIndex(10)
//            .clipped()
            .padding(.trailing, -1)
            .padding(.bottom, 0)
    }
    
    var body: some View {
        let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
        
        GeometryReader { geometry in
            NavigationView {
                
                ZStack {
                    (Color(hex: AppDefaults.AppColors.mainBgColor)).edgesIgnoringSafeArea(.all)
                
                    VStack {
                        
                        ScrollViewReader { scrollProxy in
                        
                            ScrollView(.vertical) {

                                ForEach(dialogViewModel.dialogueLines, id: \.self) { dialogueLine in
                                    
                                    HStack(alignment: .bottom, spacing: 0) {
                                        chatBubbleTriange(width: 11, height: 18)
                                        
                                        Text(dialogueLine.line)
                                            .font(.system(size: 17.0, weight: .light))
                                            .foregroundColor(Color.black)
                                            .padding(10)
                                            .background(chatBubble)
                                        
                                        Spacer()
                                    }
                                    .padding(.leading, 20)
                                    .padding(.trailing, geometry.size.width * 0.15)
                                    .padding(.top, 30)
                                }
                                .padding(.top, geometry.size.height - 100)
                                .background(Color(hex: AppDefaults.AppColors.mainBgColor))
                                .navigationBarTitle(Text("Dialogue"), displayMode: .inline)
                                .onAppear() {
                                    dialogViewModel.getDialogue()
                                }
                            }
                            .background(Color(hex: AppDefaults.AppColors.mainBgColor))
                            .onReceive(timer) { _ in
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    if showedMessageIndex < dialogViewModel.dialogueLines.count {
                                    scrollProxy.scrollTo(dialogViewModel.dialogueLines[showedMessageIndex], anchor: .bottom)
                                    showedMessageIndex += 1
                                    } else {
                                        timer.upstream.connect().cancel()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct DialogueView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DialogueView()
        }
        
    }
}
