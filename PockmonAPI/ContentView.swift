//
//  ContentView.swift
//  PockmonAPI
//
//  Created by cho on 2023/11/15.
//

//import SwiftUI
//
//struct ContentView: View {
//    
//    let types: [PokemonType] = [
//        PokemonType(name: "일반"),
//        PokemonType(name: "불꽃"),
//        PokemonType(name: "물"),
//        PokemonType(name: "전기"),
//        PokemonType(name: "풀"),
//        PokemonType(name: "얼음"),
//        PokemonType(name: "격투"),
//        PokemonType(name: "독"),
//        PokemonType(name: "땅"),
//        PokemonType(name: "비행"),
//        PokemonType(name: "에스"),
//        PokemonType(name: "벌레"),
//        PokemonType(name: "바위"),
//        PokemonType(name: "고스"),
//        PokemonType(name: "드래")
//    ]
//    
//    let typeMatchups: [String: [String]] = [
//        "normal": ["격투"],
//        "fire": ["물", "바위", "불꽃", "드래곤"],
//        "water": ["전기", "풀"],
//        "electric": ["땅"],
//        "grass": ["벌레", "독", "비행", "불꽃", "얼음"],
//        "ice": ["격투", "독", "바위", "벌레"],
//        "fighting": ["비행", "에스퍼", "페어리", "벌레", "얼음"],
//        "poison": ["땅", "에스퍼"],
//        "ground": ["물", "풀", "얼음"],
//        "flying": ["전기", "바위", "강철"],
//        "psychic": ["벌레", "고스트", "악"],
//        "bug": ["불꽃", "비행", "풀", "에스퍼", "페어리"],
//        "rock": ["물", "풀", "노멀", "불꽃", "비행"],
//        "ghost": ["노멀", "격투", "독", "벌레", "고스트"],
//        "dragon": ["드래곤"],
//       
//    ]
//    
//    @State private var selectedTypes: Set<PokemonType> = []
//    @StateObject var viewModel = ViewModel()
//    @State private var pokemon: Pokemon?
//    
//    
//    let gridSpacing: CGFloat = 15
//    let buttonSize: CGFloat = 80
//   
//    
//    var body: some View {
//        VStack {
//            Text("포켓몬을 이겨라")
//                .font(.title)
//                .padding()
//            if let image = viewModel.pokemonImage {
//                Text(viewModel.pokemonName)
//                    .font(.title)
//                    .padding()
//                Image(uiImage: image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 100, height: 100)
//                HStack {
//                    ForEach(viewModel.pokemonTypes, id: \.self) { type in
//                        Text(type)
//                            .padding(8)
//                            .foregroundColor(.black)
//                    }
//                }
//                .padding(.vertical, 8)
//                
//            } else {
//                Text("준비중")
//            }
//            
//            Button("다른 포켓몬 볼랭") {
//                viewModel.generateRandomID()
//                viewModel.fetchRandomPokemon()
//            }
//            
//            LazyVGrid(columns: createGrid(), spacing: 16) {
//                ForEach(types) { type in
//                    Button(action: {
//                        toggleTypeSelection(type)
//                    }) {
//                        VStack {
//                            //MARK: 타입의 이미지 넣을 수 있으면 넣어보자
//                            Text(type.name)
//                                .font(.headline)
//                                .padding(.top, 4)
//                        }
//                        .padding()
//                        .background(selectedTypes.contains(type) ? Color.green : Color.gray.opacity(0.2))
//                        .cornerRadius(10)
//                    }
//                    .frame(width: buttonSize, height: buttonSize)
//                }
//            }
//            .padding([.horizontal, .bottom], 4)
//            
//            
//            Button(action: {
//                handleConfirmation()
//            }) {
//                Text("확인")
//                    .font(.headline)
//                    .padding()
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//            
//            
//            if !viewModel.resultMessage.isEmpty {
//                Text(viewModel.resultMessage)
//                    .font(.headline)
//                    .padding()
//            }
//            
//        }
//                .onChange(of: viewModel.resultMessage) { _ in
//                    if !viewModel.resultMessage.isEmpty {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            viewModel.resetSelection()
//                        }
//                    }
//                }
//        }
//    
//   
//    
//    func createGrid() -> [GridItem] {
//           Array(repeating: GridItem(.flexible()), count: 5)
//       }
//       
//       func toggleTypeSelection(_ type: PokemonType) {
//           if selectedTypes.contains(type) {
//               selectedTypes.remove(type)
//           } else {
//               selectedTypes.insert(type)
//           }
//       }
//       
//    func handleConfirmation() {
//        let selectedTypeNames = selectedTypes.map { $0.name }
//        viewModel.determineBattleResult(with: selectedTypeNames)
//        selectedTypes.removeAll()
//        print("선택된 타입: \(selectedTypeNames)")
//    }
//}
//
//
