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
    
    var body: some View {
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
                ForEach(1...9, id: \.self) { index in
                    Button(action: {}) {
                        Text("\(index)세대")
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
                viewModel.fetchRandomPokemon()
            }
        }
        .onAppear {
            viewModel.fetchRandomPokemon()
        }
    }
    
    
    func checkAnswer(for generation: Generations) {
        if generation.range.contains(viewModel.randomID) {
            alertTitle = "정답입니다!"
        } else {
            alertTitle = "틀렸습니다."
        }
        showingAlert = true
    }
}

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
