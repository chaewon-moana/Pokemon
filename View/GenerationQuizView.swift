//
//  GenerationQuizView.swift
//  PockmonAPI
//
//  Created by Greed on 11/17/23.
//

import SwiftUI

struct GenerationQuizView: View {
    
    
    //    @StateObject var generationQuizViewModel = GenerationQuizViewModel()
    @StateObject var viewModel = ViewModel()
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State var pressCount = 0
    @State var isCorrect = false
    @State var goToNextPage = false
    @State var currentPokemon: Pokemon? = nil
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                VStack {
                    Text("몇 세대 포켓몬일까요오옹??")
                    if let image = viewModel.pokemonImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                        Text(viewModel.pokemonName)
                    }
                    
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 20) {
                        ForEach(Generations.allCases, id: \.self) { generation in
                            Button(action: {
                                pressCount += 1
                                checkAnswer(for: generation)
                            }) {
                                Text("\(generation.rawValue)세대")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding()
                            }
                            .buttonStyle(.borderedProminent)
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text(alertTitle))
                            }
                        }
                    }
                    .padding()
                    
                    
                    Button("shuffle") {
                        viewModel.generateRandomID()
                        viewModel.fetchRandomPokemon() { pokemon in
                            self.currentPokemon = pokemon
                        }
                    }
                    Spacer()
                    Button("업다운하러가기") {
                        goToNextPage = true
                    }
                    .disabled(!isCorrect)
                    .buttonStyle(.borderedProminent)
                    
                }
                .onAppear {
                    viewModel.generateRandomID()
                    viewModel.fetchRandomPokemon() { pokemon in
                        self.currentPokemon = pokemon
                    }
                    isCorrect = false
                    goToNextPage = false
                }
                
                Text("시도횟수 : \(pressCount)")
                    .font(.caption)
            }
            .navigationDestination(isPresented: $goToNextPage) {
                if let currentPokemon = currentPokemon {
                        UpdownQuizView(currentPokemon: currentPokemon, pokemonImage: viewModel.pokemonImage, counts: $pressCount)
                    }
            }
        }
    

    }
        
    
    
    func checkAnswer(for generation: Generations) {
        if generation.range.contains(viewModel.randomID) {
            alertTitle = "정답입니다!"
            isCorrect = true
        } else {
            alertTitle = "틀렸습니다."
        }
        showingAlert = true
    }
}
//
//#Preview {
//    GenerationQuizView()
//}

extension GenerationQuizView {
    enum Generations: Int, CaseIterable {
        case first = 1, second, third, fourth, fifth, sixth, seventh, eighth, ninth
        
        var range: ClosedRange<Int> {
            switch self {
            case .first: return 1...151
            case .second: return 152...251
            case .third: return 252...386
            case .fourth: return 387...493
            case .fifth: return 494...649
            case .sixth: return 650...721
            case .seventh: return 722...807
            case .eighth: return 810...905
            case .ninth: return 906...1017
            }
        }
    }
    
    
}
