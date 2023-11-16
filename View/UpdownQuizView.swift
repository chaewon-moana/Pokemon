//
//  UpdownQuizView.swift
//  PockmonAPI
//
//  Created by Greed on 11/17/23.
//

import SwiftUI

struct UpdownQuizView: View {
    
//    @StateObject var viewModel = ViewModel()
    var currentPokemon: Pokemon
    var pokemonImage: UIImage?
    @State private var inputNumber = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var counts: Int

    var body: some View {
        VStack {
            Text("포켓몬 도감번호 UpDown")
                .font(.title)
                .padding()
            if let image = pokemonImage {
             
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text(currentPokemon.name)
                    .font(.title)
                    .padding()
                Text("\(currentPokemon.id)")
                    .padding()
            } else {
                Text("준비중")
            }
            
//            Button("다른 포켓몬 볼랭") {
//                viewModel.generateRandomID()
//                viewModel.fetchRandomPokemon()
//            }
            
           
            TextField("도감번호를 입력하세요", text: $inputNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .padding()
            
            Button("확인") {
                counts += 1
                if let guessedNumber = Int(inputNumber) {
                    handleGuess(guessedNumber: guessedNumber)
                } else {
                    showAlert(message: "숫자를 입력하세요.")
                }
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("알림"),
                message: Text(alertMessage),
                dismissButton: .default(Text("확인"))
            )
        }
    }
    
    private func handleGuess(guessedNumber: Int) {
           if guessedNumber == currentPokemon.id {
               showAlert(message: "\(counts)번만에 맞추셨어요!🎊")
           } else if guessedNumber < currentPokemon.id {
               showAlert(message: " UP!👆, \(counts)번 째 시도 중 ")
           } else {
               showAlert(message: "DOWN!👇, \(counts)번 째 시도 중")
           }
       }

       private func showAlert(message: String) {
           alertMessage = message
           showAlert = true
       }
}


